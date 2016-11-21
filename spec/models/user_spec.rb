describe User do
    describe 'Creating a user' do
        context 'with email and password' do
            it 'should should create a user' do
                user = User.create()
                user.email = "ryan@email.com"
                user.password = "password"
                end
        end
    end
end