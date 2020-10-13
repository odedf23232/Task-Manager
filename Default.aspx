<%@ Page Title="Default" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyWebApp1.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
    <script>
        var app = angular.module('myApp', []);
        app.controller('formCtrl', function ($scope, $http) {

            $scope.page = 1;
            $scope.pageSize = 10;

            angular.element(document)
                .ready(function () {
                    $http({
                        method: 'GET',
                        url: 'MyWebService.asmx/GetUsersTasks'
                    })
                        .success(function (data) {
                            var ar = [];
                            $.each(data, function (i, v) {
                                ar.push(v);
                            })

                            $scope.user_tasks = ar;
                            console.log($scope.user_tasks);
                            $scope.pagesCount = Math.ceil($scope.user_tasks.length / $scope.pageSize);
                            if ($scope.pagesCount == 0)
                                $scope.pagesCount = 1;
                        })
                        .error(function (data) {
                            alert("data=" + data);
                        });
                });


            angular.element(".pagination a").on("click", function (e) {
                switch ($(this).text()) {
                    case "first":
                        $scope.page = 1;
                        break;
                    case "next":
                        if ($scope.page < $scope.pagesCount) $scope.page++;
                        break;
                    case "prev":
                        if ($scope.page > 1) $scope.page--;
                        break;
                    case "last":
                        $scope.page = $scope.pagesCount;
                        break;
                }
                $scope.$apply();
            });


            $scope.showModalDialog = function (task) {
                $scope.selectedItem = task;
                $scope.selectedItemOrigin = task;
                $("#mdEditItem").modal();
            }

            $scope.showDeleteModal = function (task) {
                $scope.selectedItem = task;
                $("#mdDeleteItem").modal();
            }

            $scope.clearTextboxs = function () {
                $scope.taskname = null;
                $scope.description = null;
                $scope.priority = null;
                event.preventDefault();
            }

            $scope.addRow = function (tn, td, pr) {
                if ($scope.taskName != undefined || $scope.description != undefined || $scope.priority != undefined) {
                    var newtask = [];
                    newtask.TaskName = tn;
                    newtask.TaskDescription = td;
                    newtask.priority = pr;
                    newtask.Status = "In Progress";

                    $scope.user_tasks.push(newtask);
                    $scope.pagesCount = Math.ceil($scope.user_tasks.length / 10);
                    $http({
                        method: 'post',
                        url: 'MyWebService.asmx/Insert',
                        data: "{'taskname': '" + tn + "','taskdescription': '" + td + "','priority': '" + pr + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    })
                        .success(function (data) {
                            var a = 20;
                            console.log(a);
                    })
                        .error(function (data) {
                            alert(" Error data=" + data);
                    })
                }
            };

            $scope.removeRow = function (task) {
                //var current_page = $scope.page;
                //var page_size = $scope.pageSize;
                var index;
                var task_name = task.TaskName;
                var task_description = task.TaskDescription;
                var task_priority = task.priority;
                console.log(task_name);

                //Find index of task in user_tasks array to remove
                for (var i = 0; i < $scope.user_tasks.length; i++) {
                    if (angular.equals($scope.user_tasks[i], task)) {
                        index = i;
                        break;
                    }
                }

                $http({
                    method: 'post',
                    url: 'MyWebService.asmx/Delete',
                    data: "{'taskname': '" + task_name + "','taskdescription': '" + task_description + "','priority': '" + task_priority + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"})
                .success(function (data)
                {
                    var a = 23;
                    console.log(a);
                    $scope.user_tasks.splice(index, 1);
                    $('#mdDeleteItem').modal('hide');
                    $scope.$apply();
                })
                .error(function (data) {
                    alert(" Error data=" + data);
                });
            }

            $scope.saveItem = function (task_name, task_description, task_priority, status) {
                var index;            
                console.log(task_name);
                console.log(task_description);
                console.log(task_priority);
                console.log(status);

                //Find index of task in user_tasks array to edit
                for (var i = 0; i < $scope.user_tasks.length; i++) {
                    if (angular.equals($scope.user_tasks[i], $scope.selectedItemOrigin)) {
                        index = i;
                        break;
                    }
                } 

                $http({
                    method: 'post',
                    url: 'MyWebService.asmx/Update',
                    data: "{'taskname': '" + task_name + "','taskdescription': '" + task_description + "','priority': '" + task_priority + "','status': '" + status + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                .success(function (data) {
                    var a = 32;
                    console.log(a);
                    $scope.user_tasks[index] = $scope.selectedItem;
                    $('#mdEditItem').modal('hide');
                    $scope.$apply();
                })
                .error(function (data) {
                    alert(" Error data=" + data);
                });
            }

            $scope.progressVal = function () {
                var count = 0;
                for (var i = 0; i < $scope.user_tasks.length; i++) {
                    if (angular.equals($scope.user_tasks[i].Status, "Completed"))
                        count++;
                }
                var current_progress = Math.ceil(count / $scope.user_tasks.length * 100);               
                return current_progress;
            }

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div data-ng-app="myApp" data-ng-controller="formCtrl">    

        <div style="width:1000px; margin: 20px auto">

            <nav class="navbar navbar-expand-lg navbar-dark bg-primary" >

                <div class="collapse navbar-collapse" id="navbarColor01">
                    <ul class="navbar-nav mr-auto"></ul>
                    <form class="form-inline my-2 my-lg-0" align="right">                      
                        <asp:Button runat="server" OnClick="Logout" Text="Logout" CssClass="btn btn-secondary float-right"  align="right"/>
                    </form>
                    <asp:Label runat="server" id="LabelUserName" CssClass="col-md-8 control-label"></asp:Label>
                </div>
            </nav>
            <img class="rounded mx-auto d-block" alt="Task_img" src="Images/task_list.jpg" style="height: 150px; width: 250px" />

            <!-- Progress bar -->
            <div class="form-group">
                <label class="col-form-label">Progress</label>
                <div class="progress">
                    <div class="progress-bar progress-bar-striped bg-success" ng-style="{ 'width': progressVal() +'%' }">
                        <span>{{progressVal()}}% Completed tasks</span>
                    </div>
                </div>
            </div>

            <!-- Add new task -->
            <a href="#" class="btn btn-primary" type="button" onclick="$('#taskpanel').toggle(500);">+New Task</a>
            <div id="taskpanel" style="width:600px; margin: 20px auto; display:none">
             <div class="well">
                <h3 align="center">New Task</h3>
                <div class="form-group">
                    <label class="col-form-label" for="inputDefault">Task Name</label>
                    <input type="text" class="form-control" placeholder="Enter Task Name" id="inputDefault" data-ng-model="taskname"/>
                </div>
                <div class="form-group">
                    <label class="col-form-label" for="exampleTextarea">Task Description</label>
                    <textarea class="form-control" id="exampleTextarea" rows="2" placeholder="Enter Task Description" data-ng-model="description"></textarea>
                </div>
                <div class="form-group">
                    <label class="col-form-label" for="exampleSelect1">Task Priority</label>
                    <select class="form-control" id="exampleSelect1" data-ng-model="priority" ng-init="priority='Low'">
                        <option value="Low">Low</option>
                        <option value="Medium">Medium</option>
                        <option value="High">High</option>
                        <option value="Urgent">Urgent</option>
                    </select>
                </div>

                <div class="form-group" align="center">
                    <button data-ng-click="addRow(taskname,description,priority)" class="btn btn-primary"> Add Task </button>
                    <button data-ng-click="clearTextboxs($event)" class="btn btn-primary"> Clear Input </button>
                </div>
             </div>
            </div><br /><br />
            

            <!-- Task table -->
            <div>
                <label for="searchInput">Search in tasks:</label>&nbsp;&nbsp;
                <input style="width:400px; display:inline" id="searchInput" class="form-control form-control-sm" data-ng-model="searchText"/>
            </div><br /><br />
            <table class="table table-striped table-hover table-sm">
                <thead>
                    <tr>
                        <th>Task Name</th>
                        <th>Description</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th style="width:20px;" align="right"></th>
                        <th style="width:20px;" align="right"></th>
                    </tr>
                </thead>
                <tbody id="tb">
                    <tr data-ng-repeat="user_task in user_tasks.slice(pageSize*(page-1)) | filter:searchText | limitTo : pageSize track by $index">
                        <td data-ng-bind="user_task.TaskName"/>
                        <td data-ng-bind="user_task.TaskDescription"/>
                        <td data-ng-bind="user_task.priority"/>
                        <td data-ng-bind="user_task.Status" />
                        <td></td>
                        <td><a data-ng-click="showModalDialog(user_task)" class="btn btn-info" style="color: white;">Edit</a></td>
                        <td><a data-ng-click="showDeleteModal(user_task)" class="btn btn-small btn-danger" style="color: white;">Delete</a></td>
                    </tr>
                </tbody>
            </table>

            <!-- Edit task modal -->
            <div id="mdEditItem" tabindex="-1" role="dialog" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content" style="width:700px">
                        <div class="modal-header modal-header-colored colored-header-warning" style="background-color: #57abf4;color:white">
                            <h3 class="modal-title">Edit Task</h3>
                            <button type="button" data-dismiss="modal" aria-hidden="true" class="close modal-close"><span class="mdi mdi-close"></span> X </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="readOnlyInput" class="col-3 col-lg-2 col-form-label text-right">Task Name</label>
                                <input class="form-control form-control-sm" id="readOnlyInput" style="width:555px; display:inline" type="text" readonly="" data-ng-model="selectedItem.TaskName" />
                            </div>
                            <div class="form-group row">
                                <label for="inputDescription" class="col-3 col-lg-2 col-form-label text-right">Description</label>
                                <div class="col-9 col-lg-10">
                                    <input id="inputDescription" type="text" class="form-control form-control-sm" data-ng-model="selectedItem.TaskDescription" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputPriority" class="col-3 col-lg-2 col-form-label text-right">Priority</label>
                                <div class="col-9 col-lg-10">
                                    <select class="form-control form-control-sm" id="inputPriority" data-ng-model="selectedItem.priority">
                                        <option value="Low">Low</option>
                                        <option value="Medium">Medium</option>
                                        <option value="High">High</option>
                                        <option value="Urgent">Urgent</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="inputStatus" class="col-3 col-lg-2 col-form-label text-right">Status</label>
                                <div class="col-9 col-lg-10">
                                    <select class="form-control form-control-sm" id="inputStatus" data-ng-model="selectedItem.Status">
                                        <option value="Completed">Task is completed</option>
                                        <option value="In Progress">Task is in progress</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="border-top: 1px solid #57abf4;">
                            <button type="button" class="btn btn-info" data-ng-click="saveItem(selectedItem.TaskName,selectedItem.TaskDescription,selectedItem.priority, selectedItem.Status)">Save</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div><br /><br />
            
            <!-- Delete task modal -->
            <div id="mdDeleteItem" tabindex="-1" role="dialog" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content" style="width:700px">
                        <div class="modal-header modal-header-colored colored-header-warning" style="background-color: #ffc2b3;color:black">
                            <h3 class="modal-title">Delete Task</h3>
                            <button type="button" data-dismiss="modal" aria-hidden="true" class="close modal-close"><span class="mdi mdi-close"></span> X </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <fieldset>
                                    <label class="control-label" for="readonlyField">You're about to delete the following task:</label>
                                    <input class="form-control form-control-sm" id="readonlyField" type="text" readonly="" data-ng-model="selectedItem.TaskName" /><br />
                                    <p class="text-danger">Once deleted, task cannot be restored. Delete task?</p>
                                </fieldset>
                            </div>
                        </div>
                        <div class="modal-footer" style="border-top: 1px solid #ffc2b3;">
                            <button type="button" class="btn btn-danger" data-ng-click="removeRow(selectedItem)">Confirm</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>


            <div>
                <ul class="pagination" style="display: block;">
                    <li class="page-item">
                        <a class="page-link" href="#">first</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">prev</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">next</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">last</a>
                    </li>
                    <li style="float:right;">
                        Page: <b data-ng-bind="page"></b> from <b data-ng-bind="pagesCount"></b>
                    </li>
                </ul>
            </div><br /><br /><br />
        </div>
    </div>

</asp:Content>
