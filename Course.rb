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
		if course_code.size == 7
			@code = course_code.upcase
		else
			raise ArgumentError.new("Invalid input. Course code must be according to format 'COR1234'.")
		end
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
		begin
			print "[course code], [section1] [section2] [...]: "
			entry = gets.chomp.upcase
			temp = entry.split(", ")
			code = temp[0].delete(" ").delete(",") #the course doe 
			if temp.size == 2 #it will be 2 if sections are entered 
				sections = temp[1].split(" ")
				return SpecificCourse.new(code, sections.uniq)
			else
				return Course.new(code)
			end
		rescue ArgumentError => e 
			puts e.message
			retry
		rescue NoMethodError => e
			puts "Input invalid. Check the format of your entry"
			retry
		end
		
	end	

	def self.make_courses()
		courses = []
		puts "Enter the course code, optionally followed by section numbers"
		loop do 
			courses << self.make_course()

			entry =""
			begin 
				puts "Add another course? (y/n)"
				entry = gets.chomp.downcase
			 	if (!((entry.eql? "y") || (entry.eql? "n")))
					raise ArgumentError.new("Invalid input.")
				end 
			rescue ArgumentError => e
				puts e.message
				retry
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