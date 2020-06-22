require 'populator'
require 'faker'

namespace :db do |variable|
	task populate: :environment do

		Rake::Task['db:migrate:reset'].invoke
		Rake::Task['db:seed'].invoke

#------Populating the users table 
products = {
	'product 1'  => ['Nikon D850','Product Description 1','25000.50','1900'],
	'product 2'  => ['Nikon D851','Product Description 2','30000.50','1800'],
	'product 3'  => ['Nikon D852','Product Description 3','40000.50','1700']

}

products.each_with_index do |(k, v), i|			
	Product.create!(
		name:              v[0],
		description:       v[1],
		price:             v[2],
		make:              v[3],
		product_type_id: MasterType.find_by(name: 'item').id,
		)
end

end
end