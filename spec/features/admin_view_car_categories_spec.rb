require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
  end
  scenario 'successfully' do
    # Arrange -> Preparação dos Dados
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    CarCategory.create!(name: 'Econo', daily_rate: 50, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')
    # Act -> Executar o código
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
    expect(page).to have_content('Econo')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')                    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 105,50')
    expect(page).to have_content('R$ 58,50')
    expect(page).to have_content('R$ 10,50')
    expect(page).not_to have_content('Flex')
  end

  scenario 'and no car categories are created' do
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')                    
    login_as user, scope: :user    
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')                    
    login_as user, scope: :user                        

    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                        password: '12345678')                    
    login_as user, scope: :user                        

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
  
  scenario 'and view car models' do
    # Arrange -> Preparação dos Dados
    top = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                             third_party_insurance: 10.5)
    flex = CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                              third_party_insurance: 8.5)

    CarModel.create!(name: 'Ka', year: 2021, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: top,
                     fuel_type: 'Flex')
    CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet',
                     motorization: '1.0', car_category: top,
                     fuel_type: 'Flex')
    CarModel.create!(name: 'Fiesta', year: 2019, manufacturer: 'Ford', 
                     motorization: '1.0', car_category: flex,
                     fuel_type: 'Flex')
    CarModel.create!(name: 'Cobalt', year: 2018, manufacturer: 'Chevrolet',
                     motorization: '1.0', car_category: flex,
                     fuel_type: 'Flex')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', 
                     password: '12345678')                    
                                         

    # Act -> Executar o código
    login_as user, scope: :user        
    visit root_path
    click_on 'Categorias'
    click_on top.name

    expect(page).to have_content('Top')
    expect(page).to have_link('Ka')
    expect(page).to have_content('2021')
    expect(page).to have_link('Onix')
    expect(page).to have_content('2020')
  end
  scenario 'must be logged in to view details' do
    top = CarCategory.create!(name: 'Top', daily_rate: 105.5, 
                              car_insurance: 58.5,
                              third_party_insurance: 10.5)

    visit car_category_path(top)

    expect(current_path).to eq new_user_session_path
  end
end
