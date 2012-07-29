p "setting up categories..."
['Community','Customer Feedback', 'Demographics','Education','Events', 'Healthcare', 'Human Resources',
  'Industry Specific', 'Just for Fun', 'Market Research', 'Non-Profit', 'Political', 'Other'].each do |name|
    Category.create(name: name)
end
p 'done'
