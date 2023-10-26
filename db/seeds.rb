# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faker'

Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all

doctors = []
patients = []

20.times do

  doctor = Doctor.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialty: ["Cardiologist", "Dermatologist", "Pediatrician", "Orthopedic Surgeon"].sample,
    zip_code: ["12345", "56789", "98765", "43210"].sample
  )
  doctors << doctor

  patient = Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
  patients << patient
end

20.times do
    doctor = doctors.sample
    patient = patients.sample
  
    #Si appointment existe, ne pas le répéter.
    unless Appointment.exists?(doctor: doctor, patient: patient)
      appointment = Appointment.create(
        date: Faker::Time.between(from: 1.year.ago, to: Time.now, format: :default),
        doctor: doctor,
        patient: patient,
      )
    end
end
  