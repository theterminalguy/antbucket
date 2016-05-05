module ApiControllerHelper
  def stub_authenticate
    allow_any_instance_of(
      ApplicationController
    ).to receive(:authenticate).and_return(true)
  end

  def stub_curent_user(user)
    allow_any_instance_of(
      ApplicationController
    ).to receive(:current_user).and_return(user)
  end
end
