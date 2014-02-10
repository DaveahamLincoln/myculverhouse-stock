#Allows us to use STI in the dev environment.
if Rails.env.development?
	%w[computer printer other].each do |c|
		require_dependency File.join("app","models","#{c}.rb")
	end
end