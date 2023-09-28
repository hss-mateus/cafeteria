// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import MaskController from "./mask_controller"
import RoleController from "./role_controller"
import ModalController from "./modal_controller"

application.register("mask", MaskController)
application.register("role", RoleController)
application.register("modal", ModalController)
