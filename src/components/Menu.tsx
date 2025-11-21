import React from 'react';
import { Search, X } from 'lucide-react';
import { MenuItem, CartItem } from '../types';
import { useCategories } from '../hooks/useCategories';
import MenuItemCard from './MenuItemCard';

// Preload images for better performance
const preloadImages = (items: MenuItem[]) => {
  items.forEach(item => {
    if (item.image) {
      const img = new Image();
      img.src = item.image;
    }
  });
};

interface MenuProps {
  menuItems: MenuItem[];
  addToCart: (item: MenuItem, quantity?: number, variation?: any, addOns?: any[]) => void;
  cartItems: CartItem[];
  updateQuantity: (id: string, quantity: number) => void;
}

const Menu: React.FC<MenuProps> = ({ menuItems, addToCart, cartItems, updateQuantity }) => {
  const { categories } = useCategories();
  const [activeCategory, setActiveCategory] = React.useState('hot-coffee');
  const [searchQuery, setSearchQuery] = React.useState('');

  // Preload images when menu items change
  React.useEffect(() => {
    if (menuItems.length > 0) {
      // Preload images for visible category first
      const visibleItems = menuItems.filter(item => item.category === activeCategory);
      preloadImages(visibleItems);
      
      // Then preload other images after a short delay
      setTimeout(() => {
        const otherItems = menuItems.filter(item => item.category !== activeCategory);
        preloadImages(otherItems);
      }, 1000);
    }
  }, [menuItems, activeCategory]);

  React.useEffect(() => {
    if (categories.length > 0) {
      // Set default to first category for preloading
      const defaultCategory = categories.find(cat => cat.id === 'dim-sum') || categories[0];
      if (!categories.find(cat => cat.id === activeCategory)) {
        setActiveCategory(defaultCategory.id);
      }
    }
  }, [categories, activeCategory]);


  // Filter menu items based on search query
  const filteredMenuItems = React.useMemo(() => {
    if (!searchQuery.trim()) {
      return menuItems;
    }
    const query = searchQuery.toLowerCase().trim();
    return menuItems.filter(item => 
      item.name.toLowerCase().includes(query) ||
      item.description.toLowerCase().includes(query)
    );
  }, [menuItems, searchQuery]);

  // Group filtered items by category for display
  const itemsByCategory = React.useMemo(() => {
    const grouped: Record<string, MenuItem[]> = {};
    filteredMenuItems.forEach(item => {
      if (!grouped[item.category]) {
        grouped[item.category] = [];
      }
      grouped[item.category].push(item);
    });
    return grouped;
  }, [filteredMenuItems]);

  const hasSearchResults = searchQuery.trim().length > 0;
  const displayCategories = hasSearchResults 
    ? categories.filter(cat => itemsByCategory[cat.id]?.length > 0)
    : categories;

  return (
    <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div className="text-center mb-8">
        <h2 className="text-4xl font-sans font-bold text-black mb-4">Our Menu</h2>
        <p className="text-black/70 max-w-2xl mx-auto font-sans mb-8">
          "Welcome to BrB coffee and Food, your all-in-one destination for great coffee and hearty comfort food."
        </p>
        
        {/* Search Bar */}
        <div className="max-w-2xl mx-auto mb-8">
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
              <Search className="h-5 w-5 text-black/40" />
            </div>
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search for menu items..."
              className="w-full pl-12 pr-12 py-3 md:py-4 border-2 border-brand-primary/20 rounded-xl focus:ring-2 focus:ring-brand-primary focus:border-brand-primary transition-all duration-200 text-black placeholder-black/40 font-sans text-base md:text-lg bg-white shadow-sm"
            />
            {searchQuery && (
              <button
                onClick={() => setSearchQuery('')}
                className="absolute inset-y-0 right-0 pr-4 flex items-center text-black/40 hover:text-black transition-colors duration-200"
              >
                <X className="h-5 w-5" />
              </button>
            )}
          </div>
          {hasSearchResults && (
            <p className="text-sm text-black/60 mt-3 font-sans">
              Found {filteredMenuItems.length} item{filteredMenuItems.length !== 1 ? 's' : ''} matching "{searchQuery}"
            </p>
          )}
        </div>
      </div>

      {displayCategories.length === 0 && hasSearchResults ? (
        <div className="text-center py-16">
          <div className="text-6xl mb-4">🔍</div>
          <h3 className="text-2xl font-sans font-bold text-black mb-2">No items found</h3>
          <p className="text-black/60 font-sans">Try searching with different keywords</p>
        </div>
      ) : (
        displayCategories.map((category) => {
          const categoryItems = itemsByCategory[category.id] || [];
          
          if (categoryItems.length === 0) return null;
          
          return (
            <section key={category.id} id={category.id} className="mb-16">
              <div className="flex items-center mb-8">
                <span className="text-3xl mr-3">{category.icon}</span>
                <h3 className="text-3xl font-sans font-bold text-black">{category.name}</h3>
                {hasSearchResults && (
                  <span className="ml-3 text-sm text-black/60 font-sans">
                    ({categoryItems.length} {categoryItems.length === 1 ? 'item' : 'items'})
                  </span>
                )}
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {categoryItems.map((item) => {
                  const cartItem = cartItems.find(cartItem => cartItem.id === item.id);
                  return (
                    <MenuItemCard
                      key={item.id}
                      item={item}
                      onAddToCart={addToCart}
                      quantity={cartItem?.quantity || 0}
                      onUpdateQuantity={updateQuantity}
                    />
                  );
                })}
              </div>
            </section>
          );
        })
      )}
    </main>
  );
};

export default Menu;