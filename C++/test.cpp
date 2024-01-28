// Submitted by: Moti Abebe

/* Purpose:
This program is a student management system that allows the user to view, add, edit and delete students. 
The program also allows the user to view teachers and courses. 
The program uses a structure to store information about students, teachers and courses from a text file. */

#include <iostream>
#include <fstream>
#include "struct_def.h"
using namespace std;

int studentCounter, teacherCounter, courseCounter; // global counter's

ifstream importData; // input & output file streams
ofstream exportData; 

void countLine();
void loadData(Students *student, Teachers *teacher, Courses *course);
void runAction (int loadChoice, Students *student, Teachers *teacher, Courses *course);
void showStudents(Students *student);
void viewCourseEnrollment(int courseID, Students *student, Teachers *teacher, Courses *cours);
void addStudent(Students *student, Teachers *teacher, Courses *course);
void editStudent(Students *student, Teachers *teacher, Courses *course);
void deleteStudent(Students *student, Teachers *teacher, Courses *course);


int main () {
    countLine();   // count the number lines of the file

    Students *student = new Students[studentCounter];
    Teachers *teacher = new Teachers[teacherCounter];
    Courses *course = new Courses[courseCounter];

    loadData(student, teacher, course);    // load data from the file

    cout << "\n\n\t\t\tWelcome to Student Management System \n" << endl;
    cout << "\t\t\t-------------------------------------" << endl;
    cout << "\nActions: " << endl;
    cout << "[1]. View Teachers" << endl;
    cout << "[2]. View Students" << endl;
    cout << "[3]. View Course Enrollment" << endl;
    cout << "[4]. View Entire Enrollment" << endl;
    cout << "[5]. Add Student" << endl;
    cout << "[6]. Edit Student" << endl;
    cout << "[7]. Delete Student \n" << endl;

    int loadChoice;
    char stateChoice;
    do {
        cout << "Enter a corrsponding number to perform an action: ";
        cin >> loadChoice;
        runAction(loadChoice, student, teacher, course);
        cout << "\nDo you want to continue? (y/n): ";
        cin >> stateChoice;
    } while (stateChoice == 'y' || stateChoice == 'Y');

    cout << "\n\n\t\t\tThank you for using Student Management System \n" << endl;

    return 0;
}

void countLine() {
    string importedLine;

    // import student data
    importData.open("student.txt");
    if(!importData) {
        cout << "Student file not found, please check the file name and path" << endl;
        return;
    } else {
        while (!importData.eof()) {
            getline(importData, importedLine); 
            studentCounter++; // increase counter
        }
        importData.close();
    }
    
    // import teacher data
    importData.open("teacher.txt");
    if(!importData) {
        cout << "Teacher file not found, please check the file name and path" << endl;
        return;
    } else {
        while (!importData.eof()) {
            getline(importData, importedLine);
            teacherCounter++;
        }
        importData.close();
    }

    // import course data
    importData.open("course.txt");
    if(!importData) {
        cout << "Course file not found, please check the file name and path" << endl;
        return;
    } else {
        while (!importData.eof()) {
            getline(importData, importedLine);
            courseCounter++;
        }
        importData.close();
    }
}

void loadData(Students *student, Teachers *teacher, Courses *course) {
    // load data from the file
    importData.open("student.txt");
    for(int i = 0; i < studentCounter; i++) {
        importData >> student[i].studentID >> student[i].studentName >> student[i].studentBatch >> student[i].courseID;
    }
    importData.close();

    importData.open("teacher.txt");
    for(int i = 0; i < teacherCounter; i++) {
        importData >> teacher[i].teacherID >> teacher[i].teacherName >> teacher[i].teacherLevel >> teacher[i].courseID;
    }
    importData.close();

    importData.open("course.txt");
    for(int i = 0; i < courseCounter; i++) {
        importData >> course[i].courseID >> course[i].courseName >> course[i].courseHrs;
    }
    importData.close();
}

void runAction (int loadChoice, Students *student, Teachers *teacher, Courses *course) {
    string searchStatus;
    switch (loadChoice) {
        case 1:
            cout << "\nTeachers: \n" << endl;
            for (int i = 0; i < teacherCounter; i++) {
                cout << "Name: " << teacher[i].teacherName << "\t ID: " << teacher[i].teacherID << "\t Level:" << teacher[i].teacherLevel;
                for (int j = 0; j < courseCounter; j++) {
                    if (teacher[i].courseID == course[j].courseID) {
                        cout << "\t Course: " << course[j].courseName << endl;
                    }
                }
            }
            break;
        case 2:
            showStudents(student);
            break;
        case 3:
            cout << "\nCourses \n-------" << endl;
            for(int i = 0; i < courseCounter; i++) {
                cout << "ID: " << course[i].courseID  << " \t Name: " << course[i].courseName << endl;
            }
            cout << "\n\nEnter Course ID to view enrollment: ";
            int courseID;
            cin >> courseID;
            
            // loop through course array to check if courseID exists
            for (int i = 0; i < courseCounter; i++) {
                if (courseID == course[i].courseID) {
                    searchStatus = "Found";
                    viewCourseEnrollment(courseID, student, teacher, course);
                    break;
                } else {
                    searchStatus = "Not Found";
                }
            }
                if(searchStatus == "Not Found") {
                    cout << "Course ID does not exist" << endl;
                }
            break;
        case 4:
            cout << "\n\t\t\tEntire Enrollment: \n" << endl;
            for (int i = 0; i < studentCounter; i++) {
                cout << "Student Name: " << student[i].studentName;
                int cID = student[i].courseID;
                for (int j = 0; j < courseCounter; j++ ) {
                    if (cID == course[j].courseID) {
                        cout << " \t Course Name: " << course[j].courseName << endl;
                    }
                }
            }
            break;
        case 5:
            addStudent(student, teacher, course);
            break;
        case 6:
            editStudent(student, teacher, course);
            break;
        case 7:
            deleteStudent(student, teacher, course);
            break;
        default:
            cout << "Invalid input" << endl;
            break;
    }
}

void showStudents(Students *student) {
    cout << "\nStudents: \n" << endl;
    for (int i = 0; i < studentCounter; i++) {
        cout << "ID: [" << student[i].studentID << "] \t" << "Name: " << student[i].studentName << " \t" << "Batch: " << student[i].studentBatch << endl;
    }
    cout << endl;
}


void viewCourseEnrollment(int courseID, Students *student, Teachers *teacher, Courses *course) {

    // view course details
    for (int i = 0; i < courseCounter; i++) {
        if (course[i].courseID == courseID) {
            cout << "\nCourse Name: " << course[i].courseName << endl;
            cout << "Course ID: " << course[i].courseID << endl;
            cout << "Credit Hours: " << course[i].courseHrs << "\n" << endl;
        }
    }

    for (int i = 0; i < teacherCounter; i++) {    // view teacher name
        if (teacher[i].courseID == courseID) {
            cout << "Course instructor: " << teacher[i].teacherName << endl;
        }
    }

    cout << "\nStudents enrolled: " << endl;    // print students enrolled with course ID
    for (int i = 0; i<studentCounter; i++) {
        if (student[i].courseID == courseID) {
            cout << "Name: " << student[i].studentName << " \tID: " << student[i].studentID << " \tBatch: " << student[i].studentBatch <<  endl;
        }
    }

}

void addStudent(Students *student, Teachers *teacher, Courses *course) {

    showStudents(student); // show students before adding a new student

    int sID, cID; 
    string sName, sBatch;

    cout << "\nAdd Student: \n" << endl;
    cout << "Student ID: ";
    cin >> sID;
    cout << "Student Name: ";
    cin >> sName;
    cout << "Student Batch: ";
    cin >> sBatch;
    cout << "Course ID: ";

    string searchStatus = "Not Found";
    while (searchStatus != "Found") {
        cin >> cID; // prompt user to enter a course ID
        for (int j = 0; j < courseCounter; j++) { // loop through course struct to check if course ID exists
            if (cID == course[j].courseID) {
                searchStatus = "Found"; // change search status to found if course ID exists & break out of loop
                cout << "Student added successfully" << endl;
                break;
            }
        }
        if(searchStatus == "Not Found") { // print error message if course ID does not exist
            cout << "Course ID does not exist. Please enter a valid course ID: ";
        }
    }
    
    studentCounter++; // increment student counter

    exportData.open("student.txt", ios::app); // update student file by appending new student data
    exportData << "\n" << sID << " " << sName << " " << sBatch << " " << cID ;
    exportData.close();

    
    delete[] student; // delete old struct object
    delete[] course;
    delete[] teacher;
    student = new Students[studentCounter]; // create new struct object with updated size
    course = new Courses[courseCounter];
    teacher = new Teachers[teacherCounter];

    loadData(student, teacher, course); // reload data from file

}

void editStudent(Students *student, Teachers *teacher, Courses *course) {
    int sID;
    string searchStatus = "Not Found";

    showStudents(student); // show students before editing a student

    cout << "\nEdit Student: \n" << endl;
    cout << "Enter Student ID to edit: ";
    cin >> sID;

    // loop through student array to check if studentID exists
    for (int i = 0; i < studentCounter; i++) {
        if (sID == student[i].studentID) {
            cout << "Student Name: ";
            cin >> student[i].studentName;
            cout << "Student Batch: ";
            cin >> student[i].studentBatch;
            cout << "Course ID: ";

            while (searchStatus != "Found") {
                cin >> student[i].courseID; // prompt user to enter a valid course ID
                for (int j = 0; j < courseCounter; j++) { // loop through course array to check if courseID exists
                    if (student[i].courseID == course[j].courseID) {
                        searchStatus = "Found";
                        break;
                    }
                }
                if(searchStatus == "Not Found") { // print error message if course ID does not exist
                    cout << "Course ID does not exist. Please enter a valid course ID: ";
                }
            } // end of while loop
        }
    }

    if(searchStatus == "Found") {
        cout << "Student edited successfully" << endl;
        exportData.open("student.txt");
        for (int i = 0; i < studentCounter; i++) {
            if(i != 0) {
                exportData << "\n";
            }
            exportData << student[i].studentID << " " << student[i].studentName << " " << student[i].studentBatch << " " << student[i].courseID;
        }
        exportData.close();
        delete[] student; // delete old struct object
        delete[] course;
        delete[] teacher;
        student = new Students[studentCounter]; // create new struct object with updated size
        course = new Courses[courseCounter];
        teacher = new Teachers[teacherCounter];

        loadData(student, teacher, course); // reload data from file
    } else if(searchStatus == "Not Found") { // print error message if course ID does not exist
        cout << "Student ID does not exist.";
    }
}

void deleteStudent(Students *student, Teachers *teacher, Courses *course) {
    int sID;
    string searchStatus = "Not Found";

    showStudents(student); // show students before deleting a student

    cout << "\nDelete Student: \n" << endl;
    cout << "Enter Student ID to delete: ";
    cin >> sID;

    // loop through student struct to check if studentID exists and write data to file except the student to be deleted

    for(int i = 0; i < studentCounter; i++) {
        // search for student ID
        if(sID == student[i].studentID) {
            searchStatus = "Found";
        }
        // write data to file except the student to be deleted
        if(searchStatus == "Found") {
            exportData.open("student.txt");
            for(int j = 0; j < studentCounter; j++) {
                if(sID != student[j].studentID) {
                    if(j != 0) { // add new line character after first line
                        exportData << "\n";
                    }
                    exportData << student[j].studentID << " " << student[j].studentName << " " << student[j].studentBatch << " " << student[j].courseID;
                }
            }
            exportData.close();
            cout << "Student deleted successfully" << endl;
            studentCounter--; // decrement student counter
        }
    }
    
    if(searchStatus == "Found") {
        delete[] student; // delete old struct object
        delete[] course;
        delete[] teacher;
        student = new Students[studentCounter]; // create new struct object with updated size
        course = new Courses[courseCounter];
        teacher = new Teachers[teacherCounter];

        loadData(student, teacher, course); // reload data from file
    }
    else {
        cout << "Student doesn't exist, please try again " << endl;
    }
}