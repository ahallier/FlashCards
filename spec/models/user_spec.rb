describeUser do
    describe 'Creating a user' do
        context 'with email and password' do
            it 'should should create a user' do
                user.email = "ryan@email.com"
                user.password = "password"
                User.create()
            end
        end
    end
end