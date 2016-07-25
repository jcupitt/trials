User.create!(
    name: "Example Admin User",
    email: "example@example.org",
    mobile: "2348973495",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true
)

99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.org"
    mobile = Faker::PhoneNumber.cell_phone
    password = "password"
    User.create!(
        name: name,
        email: email,
        mobile: mobile,
        password: password,
        password_confirmation: password
    )
end

Trial.create!(
    name: "RSV&Flu",
    logo_url: "http://imperial.crf.nihr.ac.uk/wp-content/uploads/2013/10/l-1.jpg",
    short_description: "We are looking for healthy volunteers to screen NOW for a study of common colds and Flu over Spring at Imperial College London --- World Leaders in Respiratory Medicine.",
    long_description: "Department of Respiratory Medicine at St Mary’s Hospital, Paddington is looking for volunteers aged 18 to 55 to take part in a study of FLU.

    Healthy Volunteers Needed!

    Are you interested in helping medical research?

    We are looking for healthy volunteers to screen NOW for a study of common colds and Flu over Spring at Imperial College London --- World Leaders in Respiratory Medicine.

    Please email or call us for more information

    Email: flu-rsv-study@imperial.ac.uk

    Phone number: 07872 850212

    You will be fully compensated for your time and expenses

    This project has been approved by the Research Ethics Committee London reference: 11/LO/1826"
)

Trial.create!(
    name: "Palm Oil",
    logo_url: "http://imperial.crf.nihr.ac.uk/wp-content/uploads/2013/10/g-1.jpg",
    short_description: "The Department of Investigative Medicine is conducting a study on healthy, non smoking volunteers aged 18-60 years and body mass index of 18.6-29.9kg/m2.",
    long_description: "The Department of Investigative Medicine is conducting a study on healthy, non smoking volunteers aged 18-60 years and body mass index of 18.6-29.9kg/m2.

    We are investigating the effects of different fats on blood lipids and body composition.

    You will be asked to attend the Imperial Clinical Research Facility at Hammersmith Hospital for 4 study visits and to follow a special diet over a 14 week period.

    If you are interested or would like more information please contact study team by email.

    Email: nutrition@imperial.ac.uk

    Expenses will be paid. "
)

Trial.create!(
    name: "NK3R Study",
    logo_url: "http://imperial.crf.nihr.ac.uk/wp-content/uploads/2013/10/f-1.jpg",
    short_description: "Peri- or menopausal women aged 40-62 years old having regular hot flushes/night sweats.",
    long_description: "

    What is the study about?

    Hot flushes affect 70% of menopausal women, with up to 20% of these women describing them as ‘intolerable’. Furthermore hot flushes can last up to 20 years, therefore having a significant and long-lasting effect on quality of life. Hormone Replacement Therapy (HRT) is the mainstay of treatment but confers an increased risk of breast cancer, stroke and thromboembolism. Therefore current guidelines recommend a limited duration of therapy and in several women HRT cannot be prescribed. Some other medications are available to prescribe but these are less effective than HRT. This highlights an unmet need to develop non-hormonal alternative treatments for menopausal flushing.

    Neurokinin B (NKB) is a naturally occurring hormone found in healthy people, which helps to regulate the levels of sex hormones (reproductive hormones) in humans. Recent studies in humans show that NKB signalling also controls menopausal hot flushes. We therefore think that blocking the NK3 receptor (the primary receptor for NKB) could be a new treatment approach for menopausal hot flushes.

    What does the study involve?

    Participants will attend our clinical research facility on a weekly basis for 14 weeks (these visits should typically last less than 45 minutes) at either Hammersmith or Charing Cross hospitals.

    The 14 week study period is divided into 5 parts:

    1)            two week monitoring period (you will not be receiving any study treatment)

    2)            four week treatment period (you will take tablets of the NKB blocking drug or placebo – dose 40mg twice daily (two tablets twice daily))

    3)            two week monitoring period (you will not be receiving any study treatment)

    4)            four week treatment period (you will take tablets of the NKB blocking drug or placebo – dose 40mg twice daily (two tablets twice daily))

    5)            two week monitoring period (you will not be receiving any study treatment)

    The study visits normally need to be scheduled during weekdays, but it may be possible to arrange a weekend visit during exceptional circumstances.

    The tablets are taken orally.

    At each study visit blood samples will be taken from a vein in the arm (up to 20mls (4 teaspoons of blood) will be taken each time). Throughout the study, participants will be asked to complete standard questionnaires about their symptoms on a twice daily basis (morning and evening) at home (should take a maximum of 10-15 minutes/day), and wear a small monitor on their chest for the first 48 hours of each week (this can be easily removed when washing).

    We have full ethical approval (REC ref: 15/LO/1481), and the drug has safely been given to many healthy volunteers previously.

    Expenses will be paid

    Who are we looking for?

    Peri- or menopausal women aged 40-62 years old having regular hot flushes/night sweats

    For further information: Please email Dr Julia Prague at menopause@imperial.ac.uk"
)

users = User.order(:created_at).drop(1).take(6)
50.times do
    notes = Faker::Lorem.sentence(5)
    users.each {|user| user.volunteers.create!(notes: notes, trial_id: 1)}
end
