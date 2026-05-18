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
1. Google Sign-In using Firebase Authentication
2. Persistent login session (auto-login)
3. Logout functionality
4. Proper error handling & login cancellation handling
 
# Dashboard
1. User profile (Name, Email, Profile Image)
2. Current device location (human-readable address)
3. Location permission handling:
4. Permission denied
5. Permanently denied
6. GPS disabled

# Product Module
1. Product details:
2. Image carousel with page indicators
3. Title, description, price
4. Discount calculation
5. Rating, brand, category
6. Stock/availability status
## Features
1. Infinite scrolling pagination
2. Pull-to-refresh
3. Search products
4. Filter by category
Sort by:
1. Price Low → High
2. Price High → Low
3. Rating

# Cart Module
1. Add to cart functionality
2. Prevent duplicate cart entries
3. Increase / Decrease quantity
4. Remove items
4. Real-time cart updates across screens
5. Cart badge counter
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
1. Provider (State Management)
2. Clean folder structure
3. Reusable widgets
4. Service-based architecture