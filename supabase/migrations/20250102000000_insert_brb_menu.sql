/*
  # Insert BRB Cafe & Food Corner Menu
  
  This migration inserts all menu items, categories, variations, and add-ons
  for the BRB Cafe & Food Corner menu. All IDs are auto-generated using gen_random_uuid().
*/

-- Insert/Update Categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('seasalt-series', 'Seasalt Series', '🧂', 1, true),
  ('matcha-iced', 'Matcha Series (Iced)', '🍵', 2, true),
  ('matcha-frappe', 'Matcha Series (Frappe)', '🍵', 3, true),
  ('iced-non-coffee', 'Iced Drinks (Non-Coffee)', '🧊', 4, true),
  ('frappe-non-coffee', 'Frappe (Non-Coffee)', '🥤', 5, true),
  ('frappe-coffee', 'Frappe (Coffee)', '☕', 6, true),
  ('special-flavors', 'Special Flavors', '🌟', 7, true),
  ('iced-coffee', 'Iced Coffee', '☕', 8, true),
  ('hot-drinks', 'Hot Drinks', '🔥', 9, true),
  ('new-in-menu', 'New in Menu', '🆕', 10, true),
  ('croffles-classic', 'Croffles (Classic)', '🧇', 11, true),
  ('croffles-premium', 'Croffles (Premium)', '🧇', 12, true),
  ('snacks-buy-one-take-one', 'Snacks (Buy One Take One)', '🍔', 13, true),
  ('snacks-solo', 'Snacks (Solo)', '🍔', 14, true),
  ('snacks-meals-fries', 'Snacks (Meals & Fries)', '🍟', 15, true),
  ('silog-meals', 'Silog Meals', '🍳', 16, true),
  ('other-meals', 'Other Meals', '🍗', 17, true)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  icon = EXCLUDED.icon,
  sort_order = EXCLUDED.sort_order,
  active = EXCLUDED.active,
  updated_at = now();

-- ==================================================
-- SEASALT SERIES MENU
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Seasalt Choco', 'Seasalt chocolate (Regular)', 90, 'seasalt-series', false, true),
  ('Seasalt Latte', 'Seasalt latte (Regular)', 100, 'seasalt-series', true, true),
  ('Seasalt Matcha', 'Seasalt matcha (Regular)', 105, 'seasalt-series', false, true);

-- Add Large upgrade as add-on for Seasalt Series
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Upgrade to Large size', 15, 'size-upgrade'
FROM menu_items
WHERE category = 'seasalt-series';

-- ==================================================
-- MATCHA SERIES (ICED)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Matcha Latte', 'Matcha latte with full cream milk, condensed milk and matcha', 90, 'matcha-iced', false, true),
  ('Dirty Matcha', 'Matcha with espresso shot, full cream milk, condensed milk and matcha', 100, 'matcha-iced', true, true),
  ('Strawberry Matcha', 'Matcha with strawberry jam, full cream milk, condensed milk and matcha', 95, 'matcha-iced', false, true),
  ('Mango Matcha', 'Matcha with mango jam, full cream milk, condensed milk and matcha', 95, 'matcha-iced', false, true);

-- Add Large variations for Iced Matcha
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 
  CASE 
    WHEN base_price = 90 THEN 15
    WHEN base_price = 100 THEN 10
    WHEN base_price = 95 THEN 15
  END
FROM menu_items
WHERE category = 'matcha-iced';

-- ==================================================
-- FRAPPE (BLENDED) - MATCHA SERIES
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Oreo Matcha Frappe', 'Oreo and matcha blended frappe', 100, 'matcha-frappe', false, true),
  ('Matcha Chip Frappe', 'Matcha with chips blended frappe', 100, 'matcha-frappe', false, true),
  ('Strawberry Matcha Frappe', 'Strawberry and matcha blended frappe', 100, 'matcha-frappe', false, true);

-- Add Large variations for Matcha Frappe
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 15
FROM menu_items
WHERE category = 'matcha-frappe';

-- ==================================================
-- ICED DRINKS (NON COFFEE)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Coke Float', 'Classic coke float', 50, 'iced-non-coffee', false, true),
  ('Iced Choco', 'Iced chocolate drink', 75, 'iced-non-coffee', false, true),
  ('Oreo Milk', 'Oreo milk drink', 85, 'iced-non-coffee', false, true),
  ('Strawberry Soda', 'Strawberry soda with Nata', 55, 'iced-non-coffee', false, true),
  ('Lychee Soda', 'Lychee soda with Nata', 55, 'iced-non-coffee', false, true),
  ('Green Apple Soda', 'Green apple soda with Nata', 55, 'iced-non-coffee', false, true),
  ('Blueberry Soda', 'Blueberry soda with Nata', 55, 'iced-non-coffee', false, true),
  ('Milky Mango', 'Mango milk drink', 85, 'iced-non-coffee', false, true),
  ('Milky Blueberry', 'Blueberry milk drink', 85, 'iced-non-coffee', false, true),
  ('Milky Strawberry', 'Strawberry milk drink', 85, 'iced-non-coffee', false, true);

-- Add Large variations for Iced Non-Coffee Drinks
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 10
FROM menu_items
WHERE category = 'iced-non-coffee';

-- ==================================================
-- FRAPPE (NON COFFEE BASED)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Choco Kisses', 'Rich chocolate blended frappe', 90, 'frappe-non-coffee', false, true),
  ('Oreo Delight', 'Creamy Oreo blended frappe', 90, 'frappe-non-coffee', false, true),
  ('Strawberry Delight', 'Sweet strawberry blended frappe', 90, 'frappe-non-coffee', false, true),
  ('Strawberry Oreo', 'Strawberry and Oreo blended frappe', 90, 'frappe-non-coffee', false, true),
  ('Black Forest', 'Chocolate and cherry blended frappe', 90, 'frappe-non-coffee', false, true);

-- Add Large variations for Non-Coffee Frappes
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 10
FROM menu_items
WHERE category = 'frappe-non-coffee';

-- ==================================================
-- FRAPPE (COFFEE BASED)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Cappuccino', 'Classic cappuccino blended frappe', 95, 'frappe-coffee', false, true),
  ('Mocha', 'Rich chocolate and coffee blended frappe', 95, 'frappe-coffee', false, true),
  ('Coffee Tofi', 'Coffee with toffee blended frappe', 95, 'frappe-coffee', false, true),
  ('Coffee Crumble', 'Coffee with crumble blended frappe', 95, 'frappe-coffee', false, true),
  ('Java Chips', 'Coffee with chocolate chips blended frappe', 100, 'frappe-coffee', false, true);

-- Add Large variations for Coffee Frappes
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 10
FROM menu_items
WHERE category = 'frappe-coffee';

-- ==================================================
-- SPECIAL FLAVORS (ICED BLENDED - LARGE)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Nutella Supreme', 'Premium Nutella blended drink (Large)', 140, 'special-flavors', true, true),
  ('Kitkat Special', 'Kitkat blended special drink (Large)', 130, 'special-flavors', false, true),
  ('Goya Mocha Chips', 'Goya mocha with chips blended drink (Large)', 135, 'special-flavors', false, true),
  ('Coffee Jelly', 'Coffee with jelly blended drink (Large)', 130, 'special-flavors', false, true),
  ('Biscoff', 'Biscoff blended drink - Non-Coffee (Large)', 145, 'special-flavors', false, true),
  ('Biscoffee', 'Biscoff coffee blended drink (Large)', 160, 'special-flavors', true, true),
  ('Strawberry Milk', 'Strawberry milk blended drink (Large)', 110, 'special-flavors', false, true),
  ('Strawberry Yogurt', 'Strawberry yogurt blended drink (Large)', 125, 'special-flavors', false, true),
  ('Mango Milk', 'Mango milk blended drink (Large)', 110, 'special-flavors', false, true),
  ('Mango Yogurt', 'Mango yogurt blended drink (Large)', 125, 'special-flavors', false, true),
  ('Blueberry Milk', 'Blueberry milk blended drink (Large)', 110, 'special-flavors', false, true),
  ('Blueberry Yogurt', 'Blueberry yogurt blended drink (Large)', 125, 'special-flavors', false, true);

-- ==================================================
-- ICED COFFEE
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Iced Spanish Latte', 'Iced Spanish latte', 85, 'iced-coffee', false, true),
  ('Iced Americano', 'Iced Americano', 65, 'iced-coffee', false, true),
  ('Iced Cappuccino', 'Iced cappuccino', 80, 'iced-coffee', false, true),
  ('Iced Latte', 'Iced latte', 80, 'iced-coffee', false, true),
  ('Iced Caramel Latte', 'Iced caramel latte', 85, 'iced-coffee', false, true),
  ('Iced Vanilla Latte', 'Iced vanilla latte', 80, 'iced-coffee', false, true),
  ('Iced Mocha', 'Iced mocha', 80, 'iced-coffee', false, true),
  ('Coffee Float', 'Coffee float', 80, 'iced-coffee', false, true),
  ('Iced Caramel Macchiato', 'Iced caramel macchiato', 90, 'iced-coffee', true, true),
  ('Oreo Latte', 'Oreo latte', 100, 'iced-coffee', false, true),
  ('Biscoff Latte', 'Biscoff latte', 100, 'iced-coffee', true, true),
  ('Iced Coffee Jelly', 'Iced coffee with jelly', 100, 'iced-coffee', false, true);

-- Add Large variations for Iced Coffee
INSERT INTO variations (menu_item_id, name, price)
SELECT id, 'Large', 
  CASE 
    WHEN name = 'Iced Spanish Latte' THEN 10
    WHEN name = 'Iced Americano' THEN 10
    WHEN name = 'Iced Cappuccino' THEN 10
    WHEN name = 'Iced Latte' THEN 10
    WHEN name = 'Iced Caramel Latte' THEN 10
    WHEN name = 'Iced Vanilla Latte' THEN 10
    WHEN name = 'Iced Mocha' THEN 10
    WHEN name = 'Coffee Float' THEN 10
    WHEN name = 'Iced Caramel Macchiato' THEN 10
    WHEN name = 'Oreo Latte' THEN 10
    WHEN name = 'Biscoff Latte' THEN 15
    WHEN name = 'Iced Coffee Jelly' THEN 15
    ELSE 10
  END
FROM menu_items
WHERE category = 'iced-coffee';

-- ==================================================
-- HOT DRINKS (12oz)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Hot Americano', 'Hot Americano (12oz)', 60, 'hot-drinks', false, true),
  ('Hot Latte', 'Hot latte (12oz)', 70, 'hot-drinks', false, true),
  ('Hot Caramel Macchiato', 'Hot caramel macchiato (12oz)', 80, 'hot-drinks', true, true),
  ('Hot Cappuccino', 'Hot cappuccino (12oz)', 75, 'hot-drinks', false, true),
  ('Hot Mocha', 'Hot mocha (12oz)', 75, 'hot-drinks', false, true),
  ('Hot Choco', 'Hot chocolate (12oz)', 55, 'hot-drinks', false, true),
  ('Hot Spanish Latte', 'Hot Spanish latte (12oz)', 75, 'hot-drinks', false, true),
  ('Hot Vanilla Latte', 'Hot vanilla latte (12oz)', 75, 'hot-drinks', false, true),
  ('Hot Matcha Latte', 'Hot matcha latte (12oz)', 65, 'hot-drinks', false, true);

-- ==================================================
-- DRINK ADD ONS / EXTRA
-- ==================================================
-- Extra Shot (for Hot and Iced Coffee)
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Shot', 20, 'drink-addons'
FROM menu_items
WHERE category IN ('hot-drinks', 'iced-coffee');

-- Whipped Cream (for Hot, Iced Coffee, and Iced Non-Coffee)
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Whipped Cream', 25, 'drink-addons'
FROM menu_items
WHERE category IN ('hot-drinks', 'iced-coffee', 'iced-non-coffee', 'frappe-non-coffee', 'frappe-coffee', 'special-flavors');

-- Coffee Jelly (for Hot and Iced Coffee)
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Coffee Jelly', 15, 'drink-addons'
FROM menu_items
WHERE category IN ('hot-drinks', 'iced-coffee');

-- Nata (for Iced Drinks and Sodas)
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Nata', 15, 'drink-addons'
FROM menu_items
WHERE category IN ('iced-coffee', 'iced-non-coffee');

-- ==================================================
-- NEW IN MENU
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Chicken Sandwich', 'New chicken sandwich', 135, 'new-in-menu', true, true),
  ('Carbonara', 'Creamy carbonara pasta', 90, 'new-in-menu', false, true),
  ('Mojos', 'Crispy mojos', 90, 'new-in-menu', false, true);

-- ==================================================
-- CROFFLES (CLASSIC FLAVORS)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Plain Croffle', 'Classic plain croffle', 60, 'croffles-classic', false, true),
  ('Sugar Glazed', 'Croffle with sugar glaze', 65, 'croffles-classic', false, true),
  ('Chocolate Glazed', 'Croffle with chocolate glaze', 70, 'croffles-classic', false, true),
  ('Caramel Glazed', 'Croffle with caramel glaze', 70, 'croffles-classic', false, true),
  ('Nutella Glazed', 'Croffle with Nutella glaze', 85, 'croffles-classic', true, true),
  ('Biscoff Glazed', 'Croffle with Biscoff glaze', 85, 'croffles-classic', true, true);

-- ==================================================
-- CROFFLES (PREMIUM FLAVORS)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Nutella Almonds', 'Croffle with Nutella and almonds', 100, 'croffles-premium', true, true),
  ('Biscoff Almonds', 'Croffle with Biscoff and almonds', 100, 'croffles-premium', true, true),
  ('Oreo Cream', 'Croffle with Oreo cream', 105, 'croffles-premium', false, true),
  ('Strawberry Cream', 'Croffle with strawberry cream', 110, 'croffles-premium', false, true),
  ('Blueberry Cream', 'Croffle with blueberry cream', 110, 'croffles-premium', false, true),
  ('Biscoff Cream', 'Croffle with Biscoff cream', 120, 'croffles-premium', true, true),
  ('Bananutella', 'Croffle with banana and Nutella', 120, 'croffles-premium', true, true),
  ('Choco Smores', 'Croffle with chocolate smores', 110, 'croffles-premium', false, true);

-- ==================================================
-- SNACKS (BUY ONE TAKE ONE)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Beef Burger (B1T1)', 'Beef burger - Buy One Take One', 55, 'snacks-buy-one-take-one', false, true),
  ('Cheeseburger (B1T1)', 'Cheeseburger - Buy One Take One', 70, 'snacks-buy-one-take-one', false, true),
  ('Hamcheeseburger (B1T1)', 'Ham and cheese burger - Buy One Take One', 90, 'snacks-buy-one-take-one', false, true),
  ('Baconcheeseburger (B1T1)', 'Bacon and cheese burger - Buy One Take One', 100, 'snacks-buy-one-take-one', false, true),
  ('Ham and Egg (B1T1)', 'Ham and egg sandwich - Buy One Take One', 75, 'snacks-buy-one-take-one', false, true);

-- ==================================================
-- SNACKS (SOLO / ALACART)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Beef Burger (Solo)', 'Beef burger - Solo', 30, 'snacks-solo', false, true),
  ('Cheeseburger (Solo)', 'Cheeseburger - Solo', 40, 'snacks-solo', false, true),
  ('Hamcheeseburger (Solo)', 'Ham and cheese burger - Solo', 50, 'snacks-solo', false, true),
  ('Baconcheeseburger (Solo)', 'Bacon and cheese burger - Solo', 55, 'snacks-solo', false, true),
  ('Ham and Egg (Solo)', 'Ham and egg sandwich - Solo', 40, 'snacks-solo', false, true);

-- ==================================================
-- SNACKS (MEALS & FRIES)
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Bucket Fries', 'Bucket of fries - Cheese, Sour Cream, BBQ or Plain Salted', 105, 'snacks-meals-fries', false, true),
  ('Solo Fries', 'Solo fries - Cheese, Sour Cream, BBQ or Plain Salted', 65, 'snacks-meals-fries', false, true),
  ('Cheesy Fries', 'Cheesy fries', 75, 'snacks-meals-fries', false, true),
  ('BRB Coke Float Bundle', 'Medium coke float + beef burger + regular fries', 100, 'snacks-meals-fries', true, true),
  ('BRB Soda Bundle', 'Medium soda + beef burger + regular fries', 100, 'snacks-meals-fries', false, true),
  ('BRB Sandwich', 'BRB special sandwich', 100, 'snacks-meals-fries', false, true),
  ('Clubhouse Sandwich With Fries', 'Clubhouse sandwich served with fries', 90, 'snacks-meals-fries', false, true);

-- ==================================================
-- SNACKS ADD ONS / EXTRA
-- ==================================================
-- Add Cheese
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Add Cheese', 10, 'snacks-addons'
FROM menu_items
WHERE category IN ('snacks-buy-one-take-one', 'snacks-solo', 'snacks-meals-fries');

-- Add Cheese Sauce
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Add Cheese Sauce', 15, 'snacks-addons'
FROM menu_items
WHERE category IN ('snacks-buy-one-take-one', 'snacks-solo', 'snacks-meals-fries');

-- Add Ham
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Add Ham', 15, 'snacks-addons'
FROM menu_items
WHERE category IN ('snacks-buy-one-take-one', 'snacks-solo', 'snacks-meals-fries');

-- Add Bacon
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Add Bacon', 20, 'snacks-addons'
FROM menu_items
WHERE category IN ('snacks-buy-one-take-one', 'snacks-solo', 'snacks-meals-fries');

-- Add Egg
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Add Egg', 15, 'snacks-addons'
FROM menu_items
WHERE category IN ('snacks-buy-one-take-one', 'snacks-solo', 'snacks-meals-fries');

-- ==================================================
-- SILOG MEALS
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Hamsilog', 'Ham silog meal', 70, 'silog-meals', false, true),
  ('Baconsilog', 'Bacon silog meal', 85, 'silog-meals', false, true),
  ('Tocilog', 'Tocino silog meal', 85, 'silog-meals', false, true),
  ('Tapsilog', 'Tapa silog meal', 85, 'silog-meals', false, true),
  ('Sisigsilog', 'Sisig silog meal', 95, 'silog-meals', true, true),
  ('Bangsilog', 'Bangus silog meal', 90, 'silog-meals', false, true),
  ('Hotsilog', 'Hotdog silog meal', 75, 'silog-meals', false, true),
  ('Chicksilog', 'Chicken silog meal', 105, 'silog-meals', false, true),
  ('Liemposilog', 'Liempo silog meal', 115, 'silog-meals', true, true);

-- ==================================================
-- OTHER MEALS
-- ==================================================
INSERT INTO menu_items (name, description, base_price, category, popular, available) VALUES
  ('Sulit Meal', 'Quarter part chicken + plain rice', 90, 'other-meals', false, true),
  ('Combo Meal', 'Quarter part chicken + plain rice + medium coke float', 125, 'other-meals', true, true),
  ('Whole Fried Chicken', 'Whole fried chicken', 300, 'other-meals', false, true),
  ('Half Chicken', 'Half fried chicken', 160, 'other-meals', false, true),
  ('Sisig Alacart', 'Sisig ala carte', 135, 'other-meals', false, true),
  ('Sizzling Hotdog', 'Sizzling hotdog', 120, 'other-meals', false, true);

-- ==================================================
-- MEAL ADD ONS / EXTRA
-- ==================================================
-- Extra Plain Rice
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Plain Rice', 15, 'meal-addons'
FROM menu_items
WHERE category IN ('silog-meals', 'other-meals');

-- Extra Fried Rice
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Fried Rice', 18, 'meal-addons'
FROM menu_items
WHERE category IN ('silog-meals', 'other-meals');

-- Extra Egg
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Egg', 15, 'meal-addons'
FROM menu_items
WHERE category IN ('silog-meals', 'other-meals');

-- Extra Mang Tomas
INSERT INTO add_ons (menu_item_id, name, price, category)
SELECT id, 'Extra Mang Tomas', 10, 'meal-addons'
FROM menu_items
WHERE category IN ('silog-meals', 'other-meals');
