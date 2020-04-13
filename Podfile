platform :ios, '13.2'

def testing_libs
  pod 'Nimble', '8.0.7'
  pod 'Quick', '2.2.0'
  pod 'Nimble-Snapshots', '8.2.0'
end

target 'AmazingRepositories' do
  use_frameworks!

  pod 'PromiseKit', '6.13.0'
  pod 'Kingfisher', '5.13.4'

  target 'AmazingRepositoriesTests' do
    inherit! :search_paths
    testing_libs
  end
  
  target 'AmazingRepositoriesFuncionalTests' do
    testing_libs
    pod 'KIF', '3.7.9'
  end

end
