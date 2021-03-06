# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# What you see below is a giant hack fest to try and get enough reference data in the db
# without having to do this manually, and letting me recreate the db easily to start over
#
# jobs and titles are hard coded... don't need more work!
chairman = Title.create(name: 'Chairman of the Board', rank: 1, max_employees: 1)
board = Title.create(name: 'Board Member', rank: 2, max_employees: 5)
chiefs = [
    Title.create(name: 'Chief Executive Officer', rank: 3, max_employees: 1),
    Title.create(name: 'Chief Financial Officer', rank: 4, max_employees: 1),
    Title.create(name: 'Chief Technology Officer', rank: 4, max_employees: 1),
    Title.create(name: 'Chief Operating Officer', rank: 4, max_employees: 1)
]
other_titles = [
    Title.create(name: 'President', rank: 5),
    Title.create(name: 'Vice President', rank: 6),
    Title.create(name: 'Department Manager', rank: 7),
    Title.create(name: 'Manager', rank: 8),
    Title.create(name: 'Staff', rank: 9)
]

# I don't know what I'll do with these yet
advisor = Job.create(name: 'Advisor')
executive = Job.create(name: 'Executive')
other_jobs = [
  Job.create(name: 'Researcher'),
  Job.create(name: 'Engineer'),
  Job.create(name: 'Manufacturer'),
  Job.create(name: 'Salesperson'),
  Job.create(name: 'Marketer'),
  Job.create(name: 'Administrative Assistant'),
  Job.create(name: 'Software Engineer'),
  Job.create(name: 'Network Engineer'),
  Job.create(name: 'Operator'),
  Job.create(name: 'Accountant'),
  Job.create(name: 'Administrator'),
]


# seed some offices
offices = [
  Office.create(street: '101 North Tryon St.', city: 'Charlotte', state: 'NC', country: 'USA', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '1 Bryant Park', city: 'New York', state: 'NY', country: 'USA', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '233 South Wacker Dr.', city: 'Chicago', state: 'IL', country: 'USA', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '900 Wilshire Blvd.', city: 'Los Angeles', state: 'CA', country: 'USA', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '1 Canary Warf', city: 'London', country: 'UK', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '60261 Frankfurt am Main', city: 'Frankfurt', country: 'Germany', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: 'Midtown Tower', city: 'Tokyo', country: 'Japan', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '300 Olympic-ro', city: 'Seoul', country: 'Korea', mail_code: MailCodesController.new.new_mail_code),
  Office.create(street: '1 Austin Rd W', city: 'West Kowloon', country: 'Hong Kong', mail_code: MailCodesController.new.new_mail_code),
]


# this section was generated by the Organization Hierarchy text output link!  Nice!
# Manually entered on the website, but then dumped into seed for reuse why we reseed new entities
department1 = Department.create(name: 'Board of Directors',
                                description: 'This is the top level department, representing the board of directors.',
                                cost_center: '1133-XSFU-922',
                                parent_department_id: nil)
department2 = Department.create(name: 'C-Suite',
                                description: 'The department containing the CEO and other C level executives.',
                                cost_center: '1434-XGXH-383',
                                parent_department_id: department1.id)
department3 = Department.create(name: 'Product Development',
                                description: 'The department responsible for all product development',
                                cost_center: '4628-PMVK-875',
                                parent_department_id: department2.id)
department5 = Department.create(name: 'Research',
                                description: 'The department responsible for all product research',
                                cost_center: '7992-FZAJ-675',
                                parent_department_id: department3.id)
department6 = Department.create(name: 'Engineering',
                                description: 'The department responsible for designing products',
                                cost_center: '7575-JOES-262',
                                parent_department_id: department3.id)
department15 = Department.create(name: 'Manufacturing',
                                 description: 'Department responsible for manufacturing products and managing factories and suppliers',
                                 cost_center: '4114-KOPH-647',
                                 parent_department_id: department3.id)
department4 = Department.create(name: 'Sales & Marketing',
                                description: 'The Sales & Marketing department.',
                                cost_center: '5782-TNTS-349',
                                parent_department_id: department2.id)
department7 = Department.create(name: 'Sales',
                                description: 'International Sales Team',
                                cost_center: '7685-RGJB-377',
                                parent_department_id: department4.id)
department8 = Department.create(name: 'Marketing',
                                description: 'The marketing department responsible for marketing products',
                                cost_center: '5981-ELXX-421',
                                parent_department_id: department4.id)
department9 = Department.create(name: 'Tech & Ops',
                                description: 'Technology and operations department',
                                cost_center: '1758-EOKO-461',
                                parent_department_id: department2.id)
department10 = Department.create(name: 'Software Engineering',
                                 description: 'The internal software engineering team',
                                 cost_center: '8887-AJRQ-273',
                                 parent_department_id: department9.id)
department11 = Department.create(name: 'Operations',
                                 description: 'The department responsible for keeping day to day operations functioning',
                                 cost_center: '4997-GPSJ-574',
                                 parent_department_id: department9.id)
department14 = Department.create(name: 'Infrastructure',
                                 description: 'The department responsible for managing computer networks and servers',
                                 cost_center: '4333-MHLU-929',
                                 parent_department_id: department9.id)
department12 = Department.create(name: 'Finance',
                                 description: 'The department responsible for financial reporting and budgeting',
                                 cost_center: '6276-CUZJ-799',
                                 parent_department_id: department2.id)
department13 = Department.create(name: 'Human Resources',
                                 description: 'The department that manages human resources',
                                 cost_center: '5212-JCAO-915',
                                 parent_department_id: department2.id)


# seed employees with celebrities!
# I debated putting this in the website, but need to get the main functionality working!
# Celebrities pulled out from my old Mazerace game, a little dated, but works :)
celebrities = [
  "Al Pacino",
  "Angelina Jolie",
  "Arnold Schwarzenegger",
  "Audrey Hepburn",
  "Barack Obama",
  "Barbra Streisand",
  "Ben Affleck",
  "Beyonce",
  "Bill Murray",
  "Billy Joel",
  "Brad Pitt",
  "Britney Spears",
  "Brooke Shields",
  "Bruce Springsteen",
  "Carrie Underwood",
  "Celine Dion",
  "Charlie Sheen",
  "Cher",
  "Clint Eastwood",
  "Courteney Cox",
  "David Letterman",
  "Demi Moore",
  "Denzel Washington",
  "Drew Barrymore",
  "Elizabeth Taylor",
  "Ellen DeGeneres",
  "Elton John",
  "Elvis Presley",
  "Eminem",
  "Faith Hill",
  "Farrah Fawcett",
  "Frank Sinatra",
  "Garth Brooks",
  "George Clooney",
  "Gwyneth Paltrow",
  "Halle Berry",
  "Harrison Ford",
  "Jack Nicholson",
  "Jackie Kennedy",
  "Jennifer Aniston",
  "Jennifer Lopez",
  "Jerry Seinfeld",
  "Jessica Simpson",
  "John Belushi",
  "John F. Kennedy Jr.",
  "John Lennon",
  "John Travolta",
  "John Wayne",
  "Johnny Carson",
  "Johnny Depp",
  "Julia Roberts",
  "Justin Bieber",
  "Justin Timberlake",
  "Kate Middleton",
  "Katharine Hepburn",
  "Katy Perry",
  "Keanu Reeves",
  "Kenny Chesney",
  "Kermit the Frog",
  "Kristen Stewart",
  "Kurt Cobain",
  "Lady Gaga",
  "Leonardo DiCaprio",
  "Lindsay Lohan",
  "Madonna",
  "Mariah Carey",
  "Marlon Brando",
  "Matt Damon",
  "Matthew McConaughey",
  "Mel Gibson",
  "Meryl Streep",
  "Michael J. Fox",
  "Michael Jackson",
  "Miley Cyrus",
  "Muhammad Ali",
  "Nicole Kidman",
  "Oprah Winfrey",
  "Paul Newman",
  "Prince Harry",
  "Prince William",
  "Princess Di",
  "Reese Witherspoon",
  "Richard Pryor",
  "Rihanna",
  "Robert De Niro",
  "Robert Pattinson",
  "Roberty Downey Jr.",
  "Robin Williams",
  "Ronald Reagan",
  "Sandra Bullock",
  "Sarah Jessica Parker",
  "Sarah Palin",
  "Shania Twain",
  "Steve Martin",
  "Taylor Swift",
  "Tiger Woods",
  "Tina Fey",
  "Tom Cruise",
  "Tom Hanks",
  "Will Smith"
]
board_department = department1
chiefs_department = department2
other_departments = Department.all.to_a
other_departments.delete(board_department)
other_departments.delete(chiefs_department)
@offices = Office.all.to_a
celebrities.shuffle! # randomize!

def make_employee(celebrity, title, job, department)
  names = celebrity.split
  # this sort of works for most :)
  if names.include?('Jr.')
    first = names[0...-2].join(' ')
    last = names[-2..].join(' ')
  else
    first = names[0...-1].join(' ')
    last = names[-1..].join(' ')
  end
  email = names.join('.') + '@jaycrowley.com'
  Employee.create(first_name: first, last_name: last, email: email,
                  title: title, job: job, department: department, office: @offices.sample)
end

# choose a chairman
make_employee(celebrities.pop, chairman, advisor, board_department)
# choose board members
(1..board.max_employees).each do
  make_employee(celebrities.pop, board, advisor, board_department)
end
# choose the executives
chiefs.each do |chief|
  make_employee(celebrities.pop, chief, executive, chiefs_department)
end

# with remaining celebrities, randomly distribute!
celebrities.each do |celebrity|
  make_employee(celebrity, other_titles.sample, other_jobs.sample, other_departments.sample)
end


# generate programs, projects, and trains. these are just made up!
[
  'Fortune 500 Clients',
  'Consumer Retail',
  'Research Initiatives',
  'Program Alpha',
  'Manufacturing Efficiency',
  'Operations Streamlining'
].each do |program|
  Program.create(name: program)
end

[
  'Chip Manufacturing',
  'Platform as a Service',
  'Tech & Ops Helpdesk',
  'Mobile (Android)',
  'Mobile (iOS)',
  'Marketing Campaigns',
  'Project Hippopotamus',
].each do |project|
  Project.create(name: project)
end

[
  'Operations',
  'Manufacturing',
  'Research',
  'Sales',
  'Project Zero',
  'Marketing',
  'Lions Team',
].each do |train|
  Train.create(name: train)
end
