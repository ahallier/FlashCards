describe User do
    describe 'Creating a user' do
        it 'should return user exists if already exists' do
            test_params = {
                "user" => {"email" => "test"}
            }
            allow(User).to receive(:exists?).and_return(true)
            expect(User).to receive(:create_user!).and_return("user exists")
            User.create_user!(test_params)
        end
        it 'should call create' do
            s = spy('test')
            t = spy('test2')
            allow(s).to receive(:require).and_return(t)
            allow(t).to receive(:permit)
            allow(User).to receive(:exists?).and_return(false)
            expect(User).to receive(:create!).and_return(spy(User))
            User.create_user!(s)
        end
    end
end