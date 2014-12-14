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
		@current_course_counter = 0
	end 

	def assign_courses(driver)
		while (!@desired_courses.empty?)
			if (get_current_course.sign_up(driver))
				remove_course(get_current_course)
			end
			next_course()
			sleep(7) #wait 10 seconds before trying again
		end
	end

	def set_courses(courses)
		#make sure the list of courses is unique
		#if there are two SpecificCourses with the same course code
		#remove the duplicates and add its sections 
		#to the original SpecificCourse
		@desired_courses = []
		for i in 0..(courses.size-1) do 
			for j in (i+1)..(courses.size-1) do
				if (!((courses[i].eql? nil) || (courses[j].eql? nil)))
					if (courses[i].code.eql? courses[j].code)
						courses[i] = courses[i].merge_course(courses[j])
						courses[j] = nil
					end
				end
			end
			if(!courses[i].eql?(nil))
				@desired_courses << courses[i]
			end
		end
	end

	def self.make_user()
		username = User.make_username
		password = User.make_password
		user = User.new(username, password)
	end 

	def self.make_username() 
		print "Enter your username: "
		username = gets.chomp
	end

	def self.make_password()
		print "Enter your password: "
		password = gets.chomp
	end

	def get_current_course()
		return @desired_courses[@current_course_counter]
	end

	def next_course()
		@current_course_counter+=1
		#wrap index around
		if @current_course_counter >= @desired_courses.size
			@current_course_counter = 0
		end
	end

	def remove_course(course)
		@desired_courses.delete(course)
	end

end 


