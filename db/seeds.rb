# encoding: utf-8
plan = Plan.find_or_create_by(name: 'Plan HCUCH', max_cases: 2147483647, max_cases_per_month: 2147483647)

institution = Institution.find_or_create_by(name: 'HCUCH', active: true, plan: plan)

user = User.new(name: 'Waldo', email: 'uribe.fache@gmail.com', password: '12345678', password_confirmation: '12345678', institution_id: institution.id, role: 'god')
user.save
