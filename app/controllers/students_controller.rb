class StudentsController < ApplicationController
  def show 
    @student = Student.find(current_student.id)
  end
end
