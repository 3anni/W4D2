require_relative './employee.rb'

require 'byebug'

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees
    end

    def add_salaries(employees)
        employees.inject(0) do |acc, employee| 
            # debugger
            acc += employee.salary
            if employee.instance_of?(Manager)
                acc += add_salaries(employee.employees)
            end
            acc
        end
    end
``


    def bonus(multiplier)
        employee_salary = add_salaries(@employees)
        employee_salary * multiplier
    end
end