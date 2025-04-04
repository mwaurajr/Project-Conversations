// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName


import { application } from "./application";

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import ReplyController from "./reply_controller"
application.register("reply", ReplyController)
