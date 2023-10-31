import ballerina/graphql;
import ballerina/io;
import ballerinax/mongodb;

//  HOD 
type Employee record {
    int Employee_id;
    string First_name;
    string Last_name;
    string Job_title;
    string Position;
    string Role;
    string Department;
    string Supervisor;
    int Employee_score;
};

type Key_Performance_Indicators record {
    string KPI_id;
    string KPI;
    int Employee_id;
    string First_name;
    string Last_name;
    float Grade;
    string Approved_or_Denied;
};

type Departments record {
    string Department_name;
    string Department_objective;
};


// Connecting the Mongo Database to our server
mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,
        auth: {
            username: "",
            password: ""
        },
        options: {
            sslEnabled: false,
            serverSelectionTimeout: 5000
        }
    },
    databaseName: "Performance_Management_System"
};

mongodb:Client db = check new (mongoConfig);
configurable string Employees_collection = "Employees";
configurable string KPIs_collection = "Key Performance Indicators";
configurable string Departments_collection = "Departments";
configurable string databaseName = "Performance_Management_System";

@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
        path: "/Performance"
    }
}

service /Management on new graphql:Listener(9090) {



 // Ignore this code I didnt have a choice
 resource function get getAllLecturers() returns string {
        return "hi";
    }



    
    // Adding an Employee
    remote function Add_an_Employee(Employee newemployee) returns error|string {
        io:println("Add an Employee function triggered");
        map<json> doc = <map<json>>newemployee.toJson();
        _ = check db->insert(doc, Employees_collection, databaseName);
        return string `${newemployee.First_name + " " + newemployee.Last_name} added successfully`;
    };

    // Adding a Department
    remote function Add_a_Department(Departments newdepartment) returns error|string {
        io:println("Add a Department function triggered");
        map<json> doc = <map<json>>newdepartment.toJson();
        _ = check db->insert(doc, Departments_collection,databaseName);
        return string `${newdepartment.Department_name} added successfully`;
    };


    // Adding a KPI
    remote function Add_a_KPI(Key_Performance_Indicators newkpi) returns error|string {
        io:println("Add a Key Permance Indicator function triggered");
        map<json> doc = <map<json>>newkpi.toJson();
        _ = check db->insert(doc, KPIs_collection,databaseName);
        return string `${newkpi.KPI_id} added successfully`;
    };

    
    // Deleting a Department Objective
   remote function Delete_a_department_objective(Departments deleteobjective) returns error|string {
        map<json> deleteobjectiveDoc = <map<json>>{"$set": {"Department objective": deleteobjective.Department_objective}};
        int updatedCount = check db->update(deleteobjectiveDoc, Departments_collection, databaseName, {Department_objective: deleteobjective.Department_objective}, true, false);
        io:println("Updated Count ", updatedCount);
        if updatedCount > 0 {
            return string `${deleteobjective.Department_name} objective deleted successfully`;
        }
        return "Failed to delete";
    }


    // Deleting an Employees KPI
     remote function Delete_an_employee_KPI(string id) returns error|string {
        mongodb:Error|int deleteKPI = db->delete(KPIs_collection, databaseName, {id: id}, false);
        if deleteKPI is mongodb:Error {
            return error("Failed to delete KPI");
        } else {
            if deleteKPI > 0 {
                return string `${id} deleted successfully`;
            } else {
                return string `KPI not found`;
            }
        }

    }


    // Updating a Department objective
    remote function Update_a_Department_objective(Departments newobjective) returns error|string {
        io:println("Update a Department objective function triggered");
        map<json> doc = <map<json>>newobjective.toJson();
        _ = check db->update(doc, Departments_collection, databaseName);
        return string `${newobjective.Department_name} updated successfully`;
    };


    // Updating an Employees KPI
    remote function Update_an_Employees_KPI(Key_Performance_Indicators updatekpi) returns error|string {
        io:println("Update an Employees KPI function triggered");
        map<json> doc = <map<json>>updatekpi.toJson();
        _ = check db->update(doc, KPIs_collection, databaseName);
        return string `${updatekpi.KPI_id} updated successfully`;
    };
}
