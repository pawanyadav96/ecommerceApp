# ecommerceapp


# Setup Instructions
1. Clone Project
   git clone https://github.com/pawanyadav96/ecommerceApp.git
2. Install Dependencies
   flutter pub get
3. Setup Firebase
   Add google-services.json in:
   android/app/
   Enable:
   Firebase Authentication (Google Sign-In)
4. Run App
   flutter run

# Authentication
Google Sign-In using Firebase Authentication
Persistent login session (auto-login)
Logout functionality
Proper error handling & login cancellation handling
 
# Dashboard
User profile (Name, Email, Profile Image)
Current device location (human-readable address)
Location permission handling:
Permission denied
Permanently denied
GPS disabled

# Product Module
Product details:
Image carousel with page indicators
Title, description, price
Discount calculation
Rating, brand, category
Stock/availability status
Features
Infinite scrolling pagination
Pull-to-refresh
Search products
Filter by category
Sort by:
Price Low → High
Price High → Low
Rating

# Cart Module
Add to cart functionality
Prevent duplicate cart entries
Increase / Decrease quantity
Remove items
Real-time cart updates across screens
Cart badge counter
 ## Cart Calculations
Subtotal
Discount calculation
Total items
Final payable amount

# Offline Support
Internet connectivity listener
No internet banner
Retry mechanism for API failures

# Architecture
Provider (State Management)
Clean folder structure
Reusable widgets
Service-based architecture