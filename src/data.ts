import type { Product } from './types';
export const categories = [
  { name: 'Phones & Tablets', icon: '📱' }, { name: 'Electronics', icon: '🎧' }, { name: 'Fashion', icon: '👟' }, { name: 'Vehicles', icon: '🚗' },
  { name: 'Property', icon: '🏠' }, { name: 'Home & Living', icon: '🛋️' }, { name: 'Beauty', icon: '💄' }, { name: 'Jobs', icon: '💼' },
  { name: 'Services', icon: '🧰' }, { name: 'Agriculture', icon: '🌾' }, { name: 'Sports', icon: '⚽' }, { name: 'Other', icon: '✨' },
];
export const products: Product[] = [
 {id:'p1',title:'iPhone 13 Pro · 256GB',price:685000,category:'Phones & Tablets',location:'Lekki, Lagos',condition:'Used',image:'https://images.unsplash.com/photo-1632633173522-6b1e2f6f0f8b?auto=format&fit=crop&w=700&q=85',seller:'Luxe Mobile',badge:'Popular'},
 {id:'p2',title:'Sony WH-1000XM5 Headphones',price:420000,category:'Electronics',location:'Ikeja, Lagos',condition:'New',image:'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?auto=format&fit=crop&w=700&q=85',seller:'SoundHub'},
 {id:'p3',title:'Classic everyday sneakers',price:58000,category:'Fashion',location:'Yaba, Lagos',condition:'New',image:'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=700&q=85',seller:'Streetwear NG'},
 {id:'p4',title:'Modern 3-seater sofa',price:350000,category:'Home & Living',location:'Ajah, Lagos',condition:'Used',image:'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=700&q=85',seller:'HomeSpace'},
 {id:'p5',title:'PlayStation 5 Slim',price:720000,category:'Electronics',location:'Surulere, Lagos',condition:'New',image:'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?auto=format&fit=crop&w=700&q=85',seller:'GamePlug',badge:'Hot deal'},
 {id:'p6',title:'Toyota Corolla 2012',price:8500000,category:'Vehicles',location:'Maryland, Lagos',condition:'Used',image:'https://images.unsplash.com/photo-1590362891991-f776e747a588?auto=format&fit=crop&w=700&q=85',seller:'AutoChoice'},
 {id:'p7',title:'Skincare gift set',price:38500,category:'Beauty',location:'Victoria Island, Lagos',condition:'New',image:'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?auto=format&fit=crop&w=700&q=85',seller:'Glow Store'},
 {id:'p8',title:'Professional home cleaning',price:25000,category:'Services',location:'Lagos, Nigeria',condition:'New',image:'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=700&q=85',seller:'FreshNest',badge:'Service'},
];
