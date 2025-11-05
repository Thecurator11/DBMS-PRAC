# MongoDB - COMPLETE ADVANCED GUIDE WITH DELIMITERS, LIMITERS & DETAILED INSTRUCTIONS

---

## **TABLE OF CONTENTS**
1. MongoDB Basics & Installation
2. Basic Commands
3. DELIMITERS - Detailed Explanation
4. LIMITERS - Detailed Explanation
5. Practical Examples with Code
6. Q19-Q22 Solutions
7. Tips & Tricks
8. Troubleshooting

---

## **PART 1: MONGODB BASICS & INSTALLATION ON UBUNTU**

### What is MongoDB?
- **NoSQL Database** - stores data as documents (JSON-like format) instead of rows/columns
- **BSON Format** - Binary JSON, similar to JSON but supports more data types
- **Flexible Schema** - documents in the same collection can have different structures
- **Scalable** - designed for horizontal scaling across multiple servers

### Key Concepts:
- **Database** = Container for collections (like a folder)
- **Collection** = Group of documents (like a table)
- **Document** = Single record with key-value pairs (like a row, but flexible)
- **_id** = Unique identifier automatically created for each document

---

## **PART 2: INSTALLATION ON UBUNTU (STEP-BY-STEP)**

### Prerequisites:
- Ubuntu 18.04 LTS or later
- sudo access
- Internet connection

### Installation Steps:

#### Step 1: Update System Packages
```bash
sudo apt-get update
sudo apt-get upgrade -y
```
**What it does:** Updates package list and upgrades existing packages to latest versions.

#### Step 2: Install MongoDB
```bash
# For Ubuntu 20.04 (Focal)
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Update package list
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org
```
**What it does:** 
- Adds MongoDB's official repository GPG key
- Adds MongoDB repository to apt sources
- Installs MongoDB server, client, and tools

#### Step 3: Start MongoDB Service
```bash
# Start MongoDB
sudo systemctl start mongod

# Verify it's running
sudo systemctl status mongod

# Enable auto-start on boot
sudo systemctl enable mongod
```

#### Step 4: Access MongoDB Shell
```bash
# Enter MongoDB interactive shell
mongosh

# For older versions (MongoDB < 5.0)
mongo
```
**Expected Output:**
```
Current Mongosh Log ID: <some_id>
Connecting to: mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh%202.x.x
Using MongoDB: <version>
Using Mongosh: <version>
```

#### Step 5: Verify Installation
```javascript
// Inside mongosh shell
db.version()  // Shows MongoDB version
show dbs      // Lists all databases
exit          // Exit shell
```

---

## **PART 3: BASIC MONGODB COMMANDS - QUICK REFERENCE**

### Database Operations
```javascript
// Show all databases
show dbs

// Use/create a database
use my_database

// Show current database
db

// Drop current database
db.dropDatabase()
```

### Collection Operations
```javascript
// Create collection
db.createCollection("employees")

// Show all collections
show collections

// Drop collection
db.employees.drop()
```

### CRUD Operations (Create, Read, Update, Delete)
```javascript
// CREATE - Insert one document
db.employees.insertOne({name: "John", salary: 50000})

// CREATE - Insert multiple documents
db.employees.insertMany([
    {name: "John", salary: 50000},
    {name: "Jane", salary: 60000}
])

// READ - Find all
db.employees.find()

// READ - Find specific
db.employees.find({name: "John"})

// UPDATE - Update one
db.employees.updateOne({name: "John"}, {$set: {salary: 55000}})

// UPDATE - Update multiple
db.employees.updateMany({}, {$set: {status: "active"}})

// DELETE - Delete one
db.employees.deleteOne({name: "John"})

// DELETE - Delete multiple
db.employees.deleteMany({salary: {$lt: 40000}})
```

---

## **PART 4: LIMITERS IN MONGODB - DETAILED EXPLANATION**

### What are Limiters?
**Limiters** restrict the number of documents returned or control the scope of operations. They help optimize queries and manage memory usage.

### Types of Limiters:

#### 1. **LIMIT - Restricts Number of Documents Returned**

**Syntax:**
```javascript
db.collection.find().limit(number)
```

**Purpose:** Returns only the specified number of documents from the result set.

**Examples:**

```javascript
// Return first 5 employees
db.employees.find().limit(5)

// Return first 10 records with pretty formatting
db.employees.find().pretty().limit(10)

// Find first 3 employees earning more than 50000
db.employees.find({salary: {$gt: 50000}}).limit(3)
```

**Use Cases:**
- Pagination (showing 10 results per page)
- Performance optimization
- Getting sample data
- Memory management

#### 2. **SKIP - Skip First N Documents**

**Syntax:**
```javascript
db.collection.find().skip(number)
```

**Purpose:** Skips the first N documents and returns the rest.

**Examples:**

```javascript
// Skip first 5 documents
db.employees.find().skip(5)

// Skip 10 and return next 5 (for pagination)
db.employees.find().skip(10).limit(5)

// Skip first 3 salary records and limit to 2
db.employees.find().skip(3).limit(2)
```

**Use Cases:**
- Pagination (page 2, 3, etc.)
- Skipping duplicates
- Offset-based data retrieval

#### 3. **SORT - Order Results**

**Syntax:**
```javascript
db.collection.find().sort({field: 1 or -1})
// 1 = ascending, -1 = descending
```

**Examples:**

```javascript
// Sort by salary ascending
db.employees.find().sort({salary: 1})

// Sort by salary descending
db.employees.find().sort({salary: -1})

// Sort by department ascending, then salary descending
db.employees.find().sort({department: 1, salary: -1})

// Sort and limit combined
db.employees.find().sort({salary: -1}).limit(3)  // Top 3 highest paid
```

#### 4. **COMBINING LIMITERS (SKIP + LIMIT + SORT)**

**Important:** Order matters! Use: **SORT → SKIP → LIMIT**

```javascript
// Pattern:
db.collection.find().sort({field: 1}).skip(n).limit(m)

// Practical Example - Pagination:
// Page 1 (records 1-10)
db.employees.find().sort({name: 1}).skip(0).limit(10)

// Page 2 (records 11-20)
db.employees.find().sort({name: 1}).skip(10).limit(10)

// Page 3 (records 21-30)
db.employees.find().sort({name: 1}).skip(20).limit(10)

// Formula: skip = (page_number - 1) * records_per_page
```

#### 5. **COUNT - Count Matching Documents**

**Syntax:**
```javascript
db.collection.find().count()
db.collection.countDocuments()
```

**Examples:**

```javascript
// Count all documents
db.employees.countDocuments()

// Count with filter
db.employees.find({department: "IT"}).count()

// Count employees earning > 50000
db.employees.countDocuments({salary: {$gt: 50000}})
```

---

## **PART 5: DELIMITERS IN MONGODB - DETAILED EXPLANATION**

### What are Delimiters?
**Delimiters** are special characters or syntax used to:
- Define boundaries between data
- Separate fields and values
- Control query scope
- Format output

### Types of Delimiters:

#### 1. **Curly Braces `{}` - Query Filters**

**Purpose:** Define query conditions in documents.

**Syntax:**
```javascript
{field: value, field2: value2}
```

**Examples:**

```javascript
// Simple equality filter
db.employees.find({department: "IT"})

// Multiple conditions (AND by default)
db.employees.find({department: "IT", salary: 60000})

// Nested field access
db.employees.find({"address.city": "Mumbai"})

// Array field
db.employees.find({skills: "Python"})
```

#### 2. **Square Brackets `[]` - Arrays & Array Operations**

**Purpose:** Define arrays of values or documents.

**Syntax:**
```javascript
db.collection.insertMany([doc1, doc2, doc3])
db.collection.find({field: {$in: [val1, val2, val3]}})
```

**Examples:**

```javascript
// Insert multiple documents
db.employees.insertMany([
    {name: "John", salary: 50000},
    {name: "Jane", salary: 60000},
    {name: "Alex", salary: 70000}
])

// Find with $in operator (values in array)
db.employees.find({department: {$in: ["IT", "HR", "Finance"]}})

// Find with $nin (values not in array)
db.employees.find({department: {$nin: ["IT", "HR"]}})

// Array field contains value
db.employees.find({skills: {$in: ["Python", "Java"]}})
```

#### 3. **Dollar Sign `$` - Operators**

**Purpose:** Indicates MongoDB operators.

**Common Operators:**

```javascript
// Comparison operators
$eq     // Equal
$ne     // Not equal
$gt     // Greater than
$gte    // Greater than or equal
$lt     // Less than
$lte    // Less than or equal
$in     // In array
$nin    // Not in array

// Logical operators
$and    // AND condition
$or     // OR condition
$not    // NOT condition
$nor    // NOR condition

// Update operators
$set    // Set value
$inc    // Increment value
$dec    // Decrement value
$push   // Add to array
$pull   // Remove from array
$unset  // Remove field

// Array operators
$addToSet   // Add if not exists
$pop        // Remove first/last
```

**Examples:**

```javascript
// Using $gt
db.employees.find({salary: {$gt: 50000}})

// Using $in
db.employees.find({department: {$in: ["IT", "HR"]}})

// Using $and
db.employees.find({$and: [{salary: {$gt: 50000}}, {department: "IT"}]})

// Using $or
db.employees.find({$or: [{department: "IT"}, {department: "HR"}]})

// Using $set in update
db.employees.updateOne({name: "John"}, {$set: {salary: 55000}})

// Using $inc in update
db.employees.updateOne({name: "John"}, {$inc: {salary: 5000}})
```

#### 4. **Dot Notation `.` - Nested Fields**

**Purpose:** Access nested document fields.

**Syntax:**
```javascript
db.collection.find({"parent.child": value})
```

**Examples:**

```javascript
// Document structure:
{
    name: "John",
    address: {
        city: "Mumbai",
        state: "Maharashtra",
        zip: "400001"
    }
}

// Query using dot notation
db.employees.find({"address.city": "Mumbai"})

// Update nested field
db.employees.updateOne({name: "John"}, {$set: {"address.city": "Pune"}})

// Query nested array
db.employees.find({"skills.0": "Python"})  // First element
```

#### 5. **Pipe `|` - Aggregation Pipeline**

**Purpose:** Chain multiple operations in aggregation.

**Syntax:**
```javascript
db.collection.aggregate([
    {$stage1: ...},
    {$stage2: ...},
    {$stage3: ...}
])
```

**Examples:**

```javascript
// Multi-stage aggregation
db.employees.aggregate([
    {$match: {department: "IT"}},
    {$group: {_id: "$department", avgSalary: {$avg: "$salary"}}},
    {$sort: {avgSalary: -1}}
])

// Filter, Group, Sort, Limit
db.employees.aggregate([
    {$match: {salary: {$gt: 50000}}},
    {$group: {_id: "$department", count: {$sum: 1}}},
    {$sort: {count: -1}},
    {$limit: 5}
])
```

---

## **PART 6: DETAILED PRACTICAL EXAMPLES WITH CODE**

### Example 1: Basic Query with Limiters

```javascript
// Setup: Create database and collection
use company_db
db.createCollection("employees")

// Insert sample data
db.employees.insertMany([
    {emp_id: 1, name: "John", dept: "IT", salary: 60000},
    {emp_id: 2, name: "Jane", dept: "HR", salary: 55000},
    {emp_id: 3, name: "Alex", dept: "IT", salary: 70000},
    {emp_id: 4, name: "Emily", dept: "Finance", salary: 80000},
    {emp_id: 5, name: "David", dept: "IT", salary: 40000},
    {emp_id: 6, name: "Don", dept: "Finance", salary: 90000}
])

// Basic find
db.employees.find()

// Find with limit
db.employees.find().limit(3)

// Find with sort and limit (top 3 highest paid)
db.employees.find().sort({salary: -1}).limit(3)

// Pagination: Page 2, 3 items per page
db.employees.find().sort({name: 1}).skip(3).limit(3)

// Find IT employees with salary > 50000
db.employees.find({dept: "IT", salary: {$gt: 50000}})
```

### Example 2: Complex Queries with Multiple Delimiters

```javascript
// Query 1: Find employees in IT or Finance department
db.employees.find({dept: {$in: ["IT", "Finance"]}})

// Query 2: Find employees NOT in IT department
db.employees.find({dept: {$nin: ["IT"]}})

// Query 3: Complex AND condition
db.employees.find({
    $and: [
        {dept: "IT"},
        {salary: {$gte: 50000}},
        {name: {$regex: "^J"}}  // Name starts with J
    ]
})

// Query 4: OR condition
db.employees.find({
    $or: [
        {dept: "IT"},
        {salary: {$gt: 80000}}
    ]
})
```

### Example 3: Aggregation Pipeline with Multiple Stages

```javascript
// Stage-by-stage aggregation
db.employees.aggregate([
    // Stage 1: Match filter
    {$match: {salary: {$gt: 50000}}},
    
    // Stage 2: Group by department
    {$group: {
        _id: "$dept",
        avgSalary: {$avg: "$salary"},
        count: {$sum: 1},
        maxSalary: {$max: "$salary"},
        minSalary: {$min: "$salary"}
    }},
    
    // Stage 3: Sort results
    {$sort: {avgSalary: -1}},
    
    // Stage 4: Limit results
    {$limit: 3},
    
    // Stage 5: Project (select fields)
    {$project: {
        _id: 1,
        avgSalary: {$round: ["$avgSalary", 2]},
        count: 1
    }}
])
```

### Example 4: Update with Delimiters

```javascript
// Update single document
db.employees.updateOne(
    {name: "John"},                    // Query (delimiter: {})
    {$set: {salary: 65000}}            // Update operator ($set)
)

// Update multiple documents
db.employees.updateMany(
    {dept: "IT"},                      // Filter
    {$inc: {salary: 5000}}             // Increment operator
)

// Update with array operations
db.employees.updateOne(
    {name: "John"},
    {$push: {skills: "Python"}}        // Add to array
)

// Update nested fields
db.employees.updateOne(
    {name: "John"},
    {$set: {"address.city": "Mumbai"}} // Dot notation
)
```

---

## **PART 7: Q19-Q22 SOLUTIONS WITH LIMITERS & DELIMITERS**

### Q19: Employee Queries with Advanced Limiters

```javascript
use company_db
db.createCollection("employees")

// Insert data
db.employees.insertMany([
    {emp_id: 1, name: "John", dept: "IT", salary: 60000, join_date: "2021-05-15"},
    {emp_id: 2, name: "Jane", dept: "HR", salary: 55000, join_date: "2020-03-10"},
    {emp_id: 3, name: "Alex", dept: "IT", salary: 70000, join_date: "2019-09-22"},
    {emp_id: 4, name: "Emily", dept: "Finance", salary: 80000, join_date: "2021-02-18"},
    {emp_id: 5, name: "David", dept: "IT", salary: 40000, join_date: "2020-06-05"},
    {emp_id: 6, name: "Don", dept: "Finance", salary: 90000, join_date: "2019-08-03"}
])

// Q1: Find all employees (with pretty formatting)
db.employees.find().pretty()

// Q2: Find employees in IT department
db.employees.find({dept: "IT"})

// Q3: Find IT employees with salary > 50000 (Using $and delimiter)
db.employees.find({
    $and: [
        {dept: "IT"},
        {salary: {$gt: 50000}}
    ]
})

// Q4: Count employees in each department (Aggregation with $group)
db.employees.aggregate([
    {$group: {_id: "$dept", count: {$sum: 1}}}
])

// Q5: Average salary by department
db.employees.aggregate([
    {$group: {_id: "$dept", avgSalary: {$avg: "$salary"}}},
    {$sort: {avgSalary: -1}}
])

// Q6: Employees joined after 2020-06-01
db.employees.find({join_date: {$gt: "2020-06-01"}})

// Q7: Update IT employees salary by 5000 (Using $inc operator)
db.employees.updateMany(
    {dept: "IT"},
    {$inc: {salary: 5000}}
)

// Q8: Delete employee with id 6
db.employees.deleteOne({emp_id: 6})

// Q9: Maximum salary in each department
db.employees.aggregate([
    {$group: {_id: "$dept", maxSalary: {$max: "$salary"}}}
])

// Q10: Departments with more than 1 employee (Using $match delimiter)
db.employees.aggregate([
    {$group: {_id: "$dept", count: {$sum: 1}}},
    {$match: {count: {$gt: 1}}}
])
```

### Q20: Student Queries with Pagination

```javascript
db.createCollection("students")

db.students.insertMany([
    {sid: 1, name: "John", age: 20, grade: "A", major: "CS"},
    {sid: 2, name: "Jane", age: 21, grade: "B", major: "Math"},
    {sid: 3, name: "Alex", age: 22, grade: "A", major: "Physics"},
    {sid: 4, name: "Emily", age: 23, grade: "C", major: "Bio"},
    {sid: 5, name: "David", age: 21, grade: "B", major: "Math"},
    {sid: 6, name: "Don", age: 22, grade: "A", major: "Math"}
])

// Q1: Find all students
db.students.find().pretty()

// Q2: Students in Computer Science (CS major)
db.students.find({major: "CS"})

// Q3: Count students in each major
db.students.aggregate([
    {$group: {_id: "$major", count: {$sum: 1}}}
])

// Q4: Grade A students (Using {} delimiter)
db.students.find({grade: "A"})

// Q5: Grades with more than 2 students
db.students.aggregate([
    {$group: {_id: "$grade", count: {$sum: 1}}},
    {$match: {count: {$gt: 2}}}
])

// Q6: Students sorted by age (Using sort limiter)
db.students.find().sort({age: 1})

// Q7: Update Emily's major to Geology
db.students.updateOne(
    {name: "Emily"},
    {$set: {major: "Geology"}}
)

// Q8: Oldest student (Using sort and limit)
db.students.find().sort({age: -1}).limit(1)

// Q9: Youngest student
db.students.find().sort({age: 1}).limit(1)

// Q10: Delete student with sid=6
db.students.deleteOne({sid: 6})

// BONUS - Pagination example:
// Page 1: First 3 students
db.students.find().sort({name: 1}).skip(0).limit(3)

// Page 2: Next 3 students
db.students.find().sort({name: 1}).skip(3).limit(3)
```

### Q21: Employee Department Queries

```javascript
db.createCollection("emp_dept")

db.emp_dept.insertMany([
    {eid: 1, ename: "Anuja", dept: "Comp", salary: 20000, gender: "F"},
    {eid: 2, ename: "Khushi", dept: "Comp", salary: 40000, gender: "M"},
    {eid: 3, ename: "Jayesh", dept: "IT", salary: 30000, gender: "F"},
    {eid: 4, ename: "Lokesh", dept: "IT", salary: 60000, gender: "M"},
    {eid: 5, ename: "Bhushan", dept: "ETC", salary: 50000, gender: "F"},
    {eid: 6, ename: "Manisha", dept: "ETC", salary: 90000, gender: "M"}
])

// Q1: Display all records
db.emp_dept.find().pretty()

// Q2: Different departments (Using $group and projection)
db.emp_dept.aggregate([
    {$group: {_id: "$dept"}}
])

// Q3: Department-wise total employees
db.emp_dept.aggregate([
    {$group: {_id: "$dept", total: {$sum: 1}}}
])

// Q4: Department-wise total salary
db.emp_dept.aggregate([
    {$group: {_id: "$dept", totalSalary: {$sum: "$salary"}}}
])

// Q5: Total salary of female employees by department (Using $match delimiter)
db.emp_dept.aggregate([
    {$match: {gender: "F"}},
    {$group: {_id: "$dept", totalSalary: {$sum: "$salary"}}}
])

// Q6: Count of male employees by department
db.emp_dept.aggregate([
    {$match: {gender: "M"}},
    {$group: {_id: "$dept", maleCount: {$sum: 1}}}
])

// Q7: Total male employees
db.emp_dept.aggregate([
    {$match: {gender: "M"}},
    {$group: {_id: null, total: {$sum: 1}}}
])

// Q8: Minimum salary in institute
db.emp_dept.aggregate([
    {$group: {_id: null, minSalary: {$min: "$salary"}}}
])

// Q9: Maximum salary in Comp department (Using $match for filtering)
db.emp_dept.aggregate([
    {$match: {dept: "Comp"}},
    {$group: {_id: null, maxSalary: {$max: "$salary"}}}
])

// Q10: All male employees sorted by name (Using sort limiter)
db.emp_dept.find({gender: "M"}).sort({ename: 1})
```

### Q22: Map-Reduce Operations

```javascript
// Map-Reduce for total salary
db.emp_dept.mapReduce(
    // Map function
    function() { 
        emit(null, this.salary); 
    },
    // Reduce function
    function(key, values) { 
        return Array.sum(values); 
    },
    // Output
    {out: "total_salary_result"}
)

// View result
db.total_salary_result.find()

// Map-Reduce for max salary
db.emp_dept.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Math.max(...values); },
    {out: "max_salary_result"}
)

// Map-Reduce for min salary
db.emp_dept.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Math.min(...values); },
    {out: "min_salary_result"}
)

// Department-wise salary using Map-Reduce
db.emp_dept.mapReduce(
    // Map: emit (dept, salary)
    function() { emit(this.dept, this.salary); },
    // Reduce: sum all salaries
    function(dept, salaries) { return Array.sum(salaries); },
    {out: "dept_salary_total"}
)

// View results
db.dept_salary_total.find()
```

---

## **PART 8: COMPREHENSIVE LIMITER & DELIMITER REFERENCE TABLE**

| Feature | Syntax | Example | Purpose |
|---------|--------|---------|---------|
| **LIMIT** | `.limit(n)` | `find().limit(5)` | Restrict documents returned |
| **SKIP** | `.skip(n)` | `find().skip(10)` | Skip first N documents |
| **SORT** | `.sort({field: 1/-1})` | `find().sort({salary: -1})` | Order results ascending(1) or descending(-1) |
| **Curly Braces** | `{}` | `find({dept: "IT"})` | Define query conditions |
| **Square Brackets** | `[]` | `find({dept: {$in: [...]}})` | Array of values |
| **Dollar Sign** | `$operator` | `{$gt: 50000}` | MongoDB operators |
| **Dot Notation** | `.` | `"address.city"` | Access nested fields |
| **Pipe** | `\|` in aggregate | `[{$match}, {$group}]` | Chain operations |
| **COUNT** | `.count()` | `find().count()` | Count documents |
| **$match** | `{$match: {}}` | `[{$match: {dept: "IT"}}]` | Filter in aggregation |
| **$group** | `{$group: {_id, ...}}` | `{$group: {_id: "$dept"}}` | Group by field |
| **$sum** | `{$sum: 1}` | `{count: {$sum: 1}}` | Count or sum values |

---

## **PART 9: IMPORTANT TIPS & TRICKS**

### 1. **Always Use Proper Order for Chaining**
```javascript
// CORRECT: sort → skip → limit
db.employees.find().sort({salary: -1}).skip(0).limit(10)

// WRONG: limit → skip → sort (don't do this)
db.employees.find().limit(10).skip(0)  // Limits first, then skips
```

### 2. **Use .pretty() for Readable Output**
```javascript
db.employees.find().pretty()
```

### 3. **Combine $match with Aggregation for Better Performance**
```javascript
// GOOD: Filter early using $match
db.employees.aggregate([
    {$match: {salary: {$gt: 50000}}},
    {$group: {_id: "$dept", count: {$sum: 1}}}
])

// AVOID: Group everything then filter
db.employees.aggregate([
    {$group: {_id: "$dept", count: {$sum: 1}}},
    {$match: {count: {$gt: 2}}}
])
```

### 4. **Use Dot Notation for Nested Fields**
```javascript
// Query nested field
db.employees.find({"address.city": "Mumbai"})

// Update nested field
db.employees.updateOne({name: "John"}, {$set: {"address.city": "Pune"}})
```

### 5. **Pagination Formula**
```javascript
// For page N with M items per page:
// skip = (N - 1) * M
// Page 1: skip(0).limit(10)
// Page 2: skip(10).limit(10)
// Page 3: skip(20).limit(10)

db.employees.find().skip((pageNum - 1) * pageSize).limit(pageSize)
```

### 6. **Use Operators Correctly**
```javascript
$eq     // {field: {$eq: value}}
$ne     // {field: {$ne: value}}
$gt     // {field: {$gt: value}}
$in     // {field: {$in: [val1, val2]}}
```

---

## **PART 10: TROUBLESHOOTING COMMON ISSUES**

### Issue 1: "Cannot find database"
```bash
# Solution: Make sure MongoDB is running
sudo systemctl status mongod

# If not running, start it
sudo systemctl start mongod
```

### Issue 2: "Operation not permitted"
```bash
# Solution: Use sudo for system commands
sudo systemctl start mongod

# But don't use sudo inside mongosh
mongosh  # No sudo here!
```

### Issue 3: "Query returned no results"
```javascript
// Check if collection exists
show collections

// Check if data was inserted
db.collection.count()

// Verify data structure
db.collection.findOne()
```

### Issue 4: "Syntax Error"
```javascript
// WRONG: Missing quotes on keys
db.employees.find({dept: IT})

// CORRECT: Quote the values
db.employees.find({dept: "IT"})

// WRONG: Wrong brackets
db.employees.find([{dept: "IT"}])

// CORRECT: Use curly braces
db.employees.find({dept: "IT"})
```

### Issue 5: "Update failed"
```javascript
// WRONG: Missing $set operator
db.employees.updateOne({name: "John"}, {salary: 60000})

// CORRECT: Use $set operator
db.employees.updateOne({name: "John"}, {$set: {salary: 60000}})
```

---

## **FINAL QUICK START CHECKLIST**

- [ ] Install MongoDB on Ubuntu
- [ ] Start MongoDB service (`sudo systemctl start mongod`)
- [ ] Access MongoDB shell (`mongosh`)
- [ ] Create database (`use mydb`)
- [ ] Create collection (`db.createCollection("name")`)
- [ ] Insert data (`db.collection.insertMany([...])`)
- [ ] Try basic queries with LIMIT and SKIP
- [ ] Practice aggregation with $match and $group
- [ ] Use dot notation for nested fields
- [ ] Combine all concepts in complex queries
- [ ] Review Q19-Q22 solutions multiple times

---

## **EXAM DAY TIPS**

1. **Always start fresh** - Create new database at start of exam
2. **Insert sample data** - Before answering queries
3. **Use .pretty()** - For readable output
4. **Double-check syntax** - Curly braces, square brackets, dollar signs
5. **Test queries** - Run small test before complex aggregations
6. **Save your work** - Export collections if needed
7. **Ask for help** - If stuck, ask the examiner for clarification
8. **Manage time** - Don't spend too long on one question

**Best of Luck with Your MongoDB Practical Exam! 🎓**