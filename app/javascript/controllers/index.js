// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import MaskController from "./mask_controller"
import RoleController from "./role_controller"
import ModalController from "./modal_controller"
import TableReservationController from "./table_reservation_controller"
import RatingController from "./rating_controller"
import FocusController from "./focus_controller"
import MessageController from "./message_controller"
import UserListController from "./user_list_controller"

application.register("mask", MaskController)
application.register("role", RoleController)
application.register("modal", ModalController)
application.register("table-reservation", TableReservationController)
application.register("rating", RatingController)
application.register("focus", FocusController)
application.register("message", MessageController)
application.register("user-list", UserListController)
