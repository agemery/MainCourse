require './Course'
require './SpecificCourse'

class User
#this class defines the User
#including member property current_schedule, which
#defines the user's pre existing schedule so the program
#knows not to pick classes over lapping the current schedule

	attr_reader :name, :password, :desired_courses, :current_schedule


	def initialize(name, password)
		@name = name
		@password = password
		@current_course_counter = 0;
	end 

	def set_courses(courses)
		@desired_courses = courses
	end

	def self.make_user()
		username = User.make_username
		password = User.make_password
		user = User.new(username, password)
	end 

	def self.make_username() 
		puts "Enter your username"
		username = gets.chomp
	end

	def self.make_password()
		puts "Enter your password"
		password = gets.chomp
	end

	def assign_courses()
		while (!@desired_courses.empty?)
			if (get_current_course.sign_up)
				remove_course(get_current_course)
			end

			next_course()
		end
	end

	def get_current_course()
		return @desired_courses[@current_course_counter]
	end

	def next_course()
		@current_course_counter++
		#wrap index around
		if @current_course_counter >= @desired_courses.size
			current_course_counter = 0
		end
	end

	def remove_course(course)
		@desired_courses.delete(course)
	end

end 


