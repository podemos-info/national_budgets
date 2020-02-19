# frozen_string_literal: true

namespace :cms_directory do
  @action_count = { created: 0, updated: 0, unchanged: 0, deleted: 0 }

  ACTION_COLORS = { created: :green, updated: :cyan, unchanged: :yellow, deleted: :red }.freeze

  TYPES_MAP = [{ model: 'Territories::Country',
                 directory_model: 'pais',
                 filter: { query: { codigo2_eq: 'ES' } },
                 default_parent_iso: nil },
               { model: 'Territories::Community',
                 directory_model: 'comunidad',
                 filter: {},
                 default_parent_iso: 'ES' },
               { model: 'Territories::Province',
                 directory_model: 'provincia',
                 filter: {},
                 default_parent_iso: nil }].freeze

  FIELDS_MAP = { territory_id: 'id', name: 'nombre_oficial', iso: 'codigo2' }.freeze

  desc 'Sincronize territories with directory'
  task sincronize_territories: :environment do
    parent_type = nil
    TYPES_MAP.each do |type|
      territories = directory_territories(type)
      type[:model] = type[:model].constantize
      @initial_territory_ids = type[:model].pluck(:id)
      print type_label(type, territories.size)
      territories.each do |territory|
        create_or_update_territory(territory, type, parent_type)
      end
      @initial_territory_ids.each do |territory_id|
        territory = type[:model].find(territory_id)
        print progress_char(territory, :deleted) if territory.destroy
      end
      parent_type = type
    end
    print result
  end

  def colorized_text(status, text)
    text.send(ACTION_COLORS[status])
  end

  def create_or_update_territory(territory, type, parent_type)
    attributes = updatable_attributes(territory, type, parent_type)
    territory = type[:model].create_with(attributes)
                            .find_or_initialize_by(territory_id: territory[FIELDS_MAP[:territory_id]])
    territory.assign_attributes(attributes) unless territory.new_record?
    print(progress_char(territory))
    territory.save! && @initial_territory_ids.delete(territory.id)
  end

  def updatable_attributes(territory, type, parent_type)
    { name: territory[FIELDS_MAP[:name]],
      iso: territory[FIELDS_MAP[:iso]],
      parent_id: territory_parent_id(territory, parent_type, type[:default_parent_iso]) }
  end

  def directory_territories(type)
    DirectorioClient.get_data(type[:directory_model], nil, type[:filter])
  end

  def parent_args(territory_id, iso)
    territory_id ? { territory_id: territory_id } : { iso: iso }
  end

  def territory_parent_id(territory, parent_type, iso)
    return unless parent_type

    parent_key = "#{parent_type[:directory_model]}_id"
    parent_type[:model].find_by(parent_args(territory[parent_key], iso))&.id
  end

  def progress_char(territory, action = nil)
    action ||= territory_action(territory)
    @action_count[action] += 1
    colorized_text(action, '·')
  end

  def result
    ["\n" * 2, @action_count.map { |status| colorized_text(status.first, "#{status.last} #{status.first}") }, "\n" * 2].join(' ' * 5)
  end

  def territory_action(territory)
    return :created if territory.new_record?
    return :updated if territory.changes.size.positive?

    :unchanged
  end

  def type_label(type, territories_size)
    "\n #{type[:model].type_name(count: 0).bold} [#{territories_size}/#{@initial_territory_ids.size}] "
  end
end
