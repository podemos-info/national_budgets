# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development? 
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless User.find_by(email:'admin@example.com')
  Budget.create!(title: 'PRESUPUESTOS GENERALES DEL ESTADO 2018', date: '2019/04/09', user_id: 1) unless Budget.find_by(title:'PRESUPUESTOS GENERALES DEL ESTADO 2018')
  Budget.create!(title: 'PRESUPUESTOS GENERALES DEL ESTADO 2019', date: '2019/01/16', user_id: 1) unless Budget.find_by(title:'PRESUPUESTOS GENERALES DEL ESTADO 2019')
  Section.create!(ref: 1, title: 'CASA DE SU MAJESTAD EL REY', budget_id: 1) unless Section.find_by(ref: 1)
  Section.create!(ref: 2, title: 'CORTES GENERALES', budget_id: 1) unless Section.find_by(ref: 2)
  Section.create!(ref: 3, title: 'TRIBUNAL DE CUENTAS', budget_id: 1) unless Section.find_by(ref: 3)
  Section.create!(ref: 4, title: 'TRIBUNAL CONSTITUCIONAL', budget_id: 1) unless Section.find_by(ref: 4)
  Section.create!(ref: 5, title: 'CONSEJO DE ESTADO', budget_id: 1) unless Section.find_by(ref: 5)
  Section.create!(ref: 6, title: 'DEUDA PÚBLICA', budget_id: 1) unless Section.find_by(ref: 6)
  Section.create!(ref: 7, title: 'CLASES PASIVAS', budget_id: 1) unless Section.find_by(ref: 7)
  Section.create!(ref: 8, title: 'CONSEJO GENERAL DEL PODER JUDICIAL', budget_id: 1) unless Section.find_by(ref: 8)
  Section.create!(ref: 9, title: 'APORTACIONES AL MUTUALISMO ADMINISTRATIVO', budget_id: 1) unless Section.find_by(ref: 9)
  Section.create!(ref: 10, title: 'CONTRATACIÓN CENTRALIZADA', budget_id: 1) unless Section.find_by(ref: 10)
  Section.create!(ref: 12, title: 'MINISTERIO DE ASUNTOS EXTERIORES Y DE COOPERACIÓN', budget_id: 1) unless Section.find_by(ref: 12)
  Section.create!(ref: 13, title: 'MINISTERIO DE JUSTICIA', budget_id: 1) unless Section.find_by(ref: 13)
  Section.create!(ref: 14, title: 'MINISTERIO DE DEFENSA', budget_id: 1) unless Section.find_by(ref: 14)
  Section.create!(ref: 15, title: 'MINISTERIO DE HACIENDA', budget_id: 1) unless Section.find_by(ref: 15)
  Section.create!(ref: 16, title: 'MINISTERIO DEL INTERIOR', budget_id: 1) unless Section.find_by(ref: 16)
  Section.create!(ref: 17, title: 'MINISTERIO DE FOMENTO', budget_id: 1) unless Section.find_by(ref: 17)
  Section.create!(ref: 18, title: 'MINISTERIO DE EDUCACIÓN Y FORMACIÓN PROFESIONAL', budget_id: 1) unless Section.find_by(ref: 18)
  Section.create!(ref: 19, title: 'MINISTERIO DE TRABAJO, MIGRACIONES Y SEGURIDAD SOCIAL', budget_id: 1) unless Section.find_by(ref: 19)
  Section.create!(ref: 20, title: 'MINISTERIO DE INDUSTRIA, COMERCIO Y TURISMO', budget_id: 1) unless Section.find_by(ref: 20)
  Section.create!(ref: 21, title: 'MINISTERIO DE AGRICULTURA, PESCA Y ALIMENTACIÓN', budget_id: 1) unless Section.find_by(ref: 21)
  Section.create!(ref: 22, title: 'MINISTERIO DE POLÍTICA TERRITORIAL Y FUNCIÓN PÚBLICA', budget_id: 1) unless Section.find_by(ref: 22)
  Section.create!(ref: 23, title: 'MINISTERIO PARA LA TRANSICIÓN ECOLÓGICA', budget_id: 1) unless Section.find_by(ref: 23)
  Section.create!(ref: 24, title: 'MINISTERIO DE CULTURA Y DEPORTE', budget_id: 1) unless Section.find_by(ref: 24)
  Section.create!(ref: 25, title: 'MINISTERIO DE LA PRESIDENCIA, RELACIONES CON LAS CORTES E IGUALDAD', budget_id: 1) unless Section.find_by(ref: 25)
  Section.create!(ref: 26, title: 'MINISTERIO DE SANIDAD, CONSUMO Y BIENESTAR SOCIAL', budget_id: 1) unless Section.find_by(ref: 26)
  Section.create!(ref: 27, title: 'MINISTERIO DE ECONOMÍA Y EMPRESA', budget_id: 1) unless Section.find_by(ref: 27)
  Section.create!(ref: 31, title: 'GASTOS DIVERSOS MINISTERIOS', budget_id: 1) unless Section.find_by(ref: 31)
  Section.create!(ref: 28, title: 'MINISTERIO DE CIENCIA, INNOVACIÓN Y UNIVERSIDADES', budget_id: 1) unless Section.find_by(ref: 28)
  Section.create!(ref: 32, title: 'OTRAS RELACIONES FINANCIERAS CON ENTES TERRITORIALES', budget_id: 1) unless Section.find_by(ref: 32)
  Section.create!(ref: 33, title: 'FONDOS DE COMPENSACIÓN INTERTERRITORIAL', budget_id: 1) unless Section.find_by(ref: 33)
  Section.create!(ref: 34, title: 'RELACIONES FINANCIERAS CON LA UNIÓN EUROPEA', budget_id: 1) unless Section.find_by(ref: 34)
  Section.create!(ref: 35, title: 'FONDO DE CONTINGENCIA', budget_id: 1) unless Section.find_by(ref: 35)
  Section.create!(ref: 36, title: 'SISTEMAS DE FINANCIACIÓN DE ENTES TERRITORIALES', budget_id: 1) unless Section.find_by(ref: 36)
  Section.create!(ref: 60, title: 'SEGURIDAD SOCIAL', budget_id: 1) unless Section.find_by(ref: 60)
end