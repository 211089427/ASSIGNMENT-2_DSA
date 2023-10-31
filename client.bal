import ballerina/io;
import ballerina/graphql;



public function Login_menu() returns error? {
    graphql:Client Client = check new ("localhost:9090/Performance");
    io:println("---------------------------------------------------------------------");
    io:println("|1.  Login as a Head Of Deparment                                   |");
    io:println("|2.  Login as a Supervisor                                          |");
    io:println("|3.  Login as an Employee                                           |");                               
    io:println("---------------------------------------------------------------------");
    string option = io:readln("Choose option: ");

 match option {
        "1" => {
           check HOD_menu();
        }


        "2" => {
           check Supervisor_menu();
        }


        "3" => {
           check Employee_menu();
        }


        _ => {
            io:println("Invalid Option");
            check Login_menu();
        }
 }
}


public function HOD_menu() returns error? {
    graphql:Client Client = check new ("localhost:9090/Performance");
    io:println("---------------------------------------------------------------------");
    io:println("|                                                                   |");
    io:println("|                       HEAD OF DEPARTMENT MENU                     |");
    io:println("|                                                                   |");
    io:println("---------------------------------------------------------------------");
    io:println("|1.  Add a new department/objective                                 |");
    io:println("|2.  Delete a department/objective                                  |");
    io:println("|3.  Update an existing departments objective                       |");
    io:println("|4.  View employees total scores                                    |");
    io:println("|5.  Assign an employee a supervisor                                |");
    io:println("|6.  Logout of user                                                 |");
    io:println("---------------------------------------------------------------------");
    string option = io:readln("Choose an option: ");

match option {
        "1" => {
          
        }


        "2" => {
          
        }


        "6" => {
           check Login_menu();
        }


        _ => {
            io:println("Invalid Option");
            check HOD_menu();
        }
 }

}


public function Supervisor_menu() returns error? {
    graphql:Client Client = check new ("localhost:9090/Performance");
    io:println("---------------------------------------------------------------------");
    io:println("|                                                                   |");
    io:println("|                           SUPERVISOR MENU                         |");
    io:println("|                                                                   |");
    io:println("---------------------------------------------------------------------");
    io:println("|1.  Approve Employee's KPIs                                        |");
    io:println("|2.  Delete Employee’s KPIs                                         |");
    io:println("|3.  Update Employee's KPIs                                         |");
    io:println("|4.  View Employee Scores [Supervisor filter]                       |");
    io:println("|5.  Grade the employee’s KPIs                                      |");
    io:println("|6.  Logout of user                                                 |");
    io:println("---------------------------------------------------------------------");
    string option = io:readln("Choose an option: ");

match option {
         "1" => {
          
        }


        "2" => {
          
        }


        "3" => {
          
        }


        "4" => {
          
        }


        "5" => {
          
        }


        "6" => {
           check Login_menu();
        }


        _ => {
            io:println("Invalid Option");
            check Supervisor_menu();
        }
 }

}




public function Employee_menu() returns error? {
    graphql:Client Client = check new ("localhost:9090/Performance");
    io:println("---------------------------------------------------------------------");
    io:println("|                                                                   |");
    io:println("|                           EMPLOYEE MENU                           |");
    io:println("|                                                                   |");
    io:println("---------------------------------------------------------------------");
    io:println("|1.  Create their KPIs                                              |");
    io:println("|2.  Grade their Supervisor                                         |");
    io:println("|3.  View Their Scores                                              |");
    io:println("|4.  Logout of user                                                 |");
    io:println("---------------------------------------------------------------------");
    string option = io:readln("Choose an option: ");

match option {
        "1" => {
         
        }


        "2" => {
        
        }


        "3" => {
           
        }


        "4" => {
            check Login_menu();
        }


        _ => {
            io:println("Invalid Option");
            check Employee_menu();
        }
 }

}
