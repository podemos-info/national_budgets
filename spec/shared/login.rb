# frozen_string_literal: true

shared_context 'with a CAS login' do
  let(:editor_user) { create(:user, user_name: 'editor_user', email: 'editor@example.org', role: :editor) }
  let(:super_admin_user) { create(:user, user_name: 'super_admin_user', email: 'super_admin@example.org', role: :super_admin) }
  let(:user_role) { :editor }

  before do
    visit budgets_path
    user = send("#{user_role}_user")
    fill_in 'username', with: user.user_name
    fill_in 'password', with: 'any password'
    click_button 'Login'
  end
end
