# toDoList-Sqllite-Swift

##Steps:
1. Create a xcode project (single view application)
2. select swift (uncheck the use core data)
3. initialize pod into the project directory
4. import the required sqlite library (pod)
5. add a navigation View Controller(VC) (make it initial)
6. add another VC for helping with the creation of TODO
7. joins the views with seagues and name them
8. drag a table and drop it in initial view (add a cell to the table and set its identifier)
9. create three swift files (DBUtil.swift for database hadeling, toDo.swift for model which conforms nsobject, and detailVC.swift which conforms to View Controller)
10. create model in toDo.swift and set getter and setter and error handling for empty data
11. in DBUtil.swift create a DB, than create a connection for connecting to DB
12. add creation, count, updation , deletion and access all mehtods
13. add code in viewcontroller.swift to handle tabel and cell for population and deletion
14. add code in detailVC.shift to handle creation and updation and timestamping

##How Does Code Work
1. when app runs a database(db) is created if it dosen't exist else the existing db is connected
2. app checks for data in table(dB) if data is present tableview(view) is populated
3. for creation app takes input from user, inserts it into table(db) with current time stamp
4. for updation app takes changes, updates the existing table(db) against certain record adds current time stamp to updated at
5. for deletion app takes the id and delete it from table and updates the model.
