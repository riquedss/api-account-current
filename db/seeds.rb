# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(name: "Henrique", 
            last_name: "gerente", 
            email: "teste2@teste.com", 
            cpf: "10476467571",
            role: 2,
            password: "123456",
            password_confirmation: "123456")
