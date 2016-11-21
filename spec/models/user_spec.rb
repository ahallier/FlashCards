describe User do
    describe 'Creating a user' do
        context 'with email and password' do
            it 'should should create a user' do
                user = [:email => "ryan@email.com", :password => "password"]
                User.create_user!(user)
            end
        end
    end
end