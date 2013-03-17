p "setting up categories..."
# Category.delete_all

['Community','Customer Feedback', 'Demographics','Education','Events', 'Healthcare', 'Human Resources',
  'Industry Specific', 'Just for Fun', 'Market Research', 'Non-Profit', 'Political', 'Other'].each do |name|
    next if Category.find_by_name(name)
    Category.create(name: name)
end
p 'done'


p "setting up survey themes..."
YAML.load_file(Rails.root.join('config', 'themes.yml')).each do |i, theme|
	next if SurveyTheme.find_by_name(theme['name'])
	SurveyTheme.create(theme)
end
st_id = SurveyTheme.first.id
Survey.where(theme_id: nil).update_all(theme_id: st_id)
p 'done'