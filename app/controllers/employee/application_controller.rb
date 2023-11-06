class Employee::ApplicationController < ApplicationController
  before_action :require_employee
end
