class Course
#this class will represent a course we are trying to add.
#if the course code is not sufficient to identify the course 
#desired, use a SpecificCourse

	attr_reader :code
	#meet_times is an array of Strings representing the acceptable
	#meeting times for the course
	#in the same format as seen in Firefox by Selenium.
	#alternatively ^, we could use section # instead....

	def initialize(course_code)
		@code = course_code 
	end 

	def sign_up(driver)
		return visit_course(driver, self)
	end

	def merge_course(course)
		if course.instance_of? Course
			return self
		elsif course.instance_of? SpecificCourse
			return course.merge_course(self)
		else
			raise "course passed is not of type Course or SpecificCourse!"
		end		
	end

	def self.make_course()
		puts "Enter the course code"
		code = gets.chomp.upcase

		#puts "Enter the course name if the course code is shared between different courses(e.g., CIS4930 is shared by Mobile Computing and Design Patterns)"
		#name = gets.chomp
		#if name.eql? ""
		#	return Course.new(code)
		#end

		puts "Enter all specific section number(s) desired, if any (enter the correct numbers!):"
		sections = gets.chomp.split(" ")

		if sections.size == 0 #if nothing was entered
			return Course.new(code)
		else
			return SpecificCourse.new(code, sections.uniq)
		end
	end	

	def self.make_courses()
		courses = []
		loop do 
			courses << self.make_course()

			entry =""
			loop do
				puts "Add another course? (y/n)"
				entry = gets.chomp.downcase
			 	if (!((entry.eql? "y") || (entry.eql? "n")))
					puts "Invalid entry."
					next
				else
					break
				end
			end

			if (entry.eql? "n")
				break
			elsif (entry.eql? "y")
				next
			end
			
		end

		return courses
	end	

	def to_string()
		return @code
	end
end 