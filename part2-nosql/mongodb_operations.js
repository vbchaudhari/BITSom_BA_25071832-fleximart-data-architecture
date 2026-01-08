// ==========================================
// FLEXIMART MONGODB OPERATIONS
// ==========================================

// ==========================================
// Operation 1: Load Data
// ==========================================
// Explanation: This command is run in the system terminal (not inside the mongo shell) 
// to import the JSON file into the database.
//
// COMMAND:
// mongoimport --db fleximart --collection products --file products_catalog.json --jsonArray


// ==========================================
// Operation 2: Basic Query
// ==========================================
// Question: Find all products in "Electronics" category with price less than 50000.
// Return only: name, price, stock

db.products.find(
    { 
        category: "Electronics", 
        price: { $lt: 50000 } 
    },
    { 
        name: 1, 
        price: 1, 
        stock: 1, 
        _id: 0 
    }
);


// ==========================================
// Operation 3: Review Analysis
// ==========================================
// Question: Find all products that have an average rating >= 4.0.
// We use the aggregation pipeline to calculate the average of the reviews array.

db.products.aggregate([
    {
        $addFields: {
            average_rating: { $avg: "$reviews.rating" }
        }
    },
    {
        $match: {
            average_rating: { $gte: 4.0 }
        }
    }
]);


// ==========================================
// Operation 4: Update Operation
// ==========================================
// Question: Add a new review to product "ELEC001".
// Review details: User U999, Rating 4, Comment "Good value".

db.products.updateOne(
    { product_id: "ELEC001" },
    { 
        $push: { 
            reviews: {
                user_id: "U999",
                username: "NewUser",
                rating: 4,
                comment: "Good value",
                date: new Date()
            } 
        } 
    }
);


// ==========================================
// Operation 5: Complex Aggregation
// ==========================================
// Question: Calculate average price by category.
// Return: category, avg_price, product_count. Sort by avg_price descending.

db.products.aggregate([
    {
        $group: {
            _id: "$category",
            avg_price: { $avg: "$price" },
            product_count: { $sum: 1 }
        }
    },
    {
        $sort: { avg_price: -1 }
    }
]);