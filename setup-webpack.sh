#!/bin/bash

# Webpack Setup Script
# This script initializes npm and installs all necessary packages for the webpack configuration

set -e  # Exit on any error

echo "🚀 Setting up Webpack project..."

# Check if package.json already exists
if [ -f "package.json" ]; then
    echo "⚠️  package.json already exists. Do you want to continue? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        exit 1
    fi
fi

# Initialize npm project if package.json doesn't exist
if [ ! -f "package.json" ]; then
    echo "📦 Initializing npm project..."
    npm init -y
    echo "✅ package.json created"
fi

# Install webpack and webpack-cli as dev dependencies
echo "📦 Installing Webpack core packages..."
npm install --save-dev webpack webpack-cli

# Install webpack plugins
echo "📦 Installing Webpack plugins..."
npm install --save-dev html-webpack-plugin

# Install loaders
echo "📦 Installing Webpack loaders..."
npm install --save-dev style-loader css-loader html-loader

# Install webpack-dev-server for development
echo "📦 Installing development server..."
npm install --save-dev webpack-dev-server

# Create basic project structure
echo "📁 Creating project structure..."
mkdir -p src
mkdir -p dist

# Create a basic template.html if it doesn't exist
if [ ! -f "src/template.html" ]; then
    cat > src/template.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Webpack App</title>
</head>
<body>
    <div id="app">
        <h1>Welcome to Webpack!</h1>
        <p>Your webpack setup is ready to go.</p>
    </div>
</body>
</html>
EOF
    echo "✅ Created src/template.html"
fi

# Create a basic index.js if it doesn't exist
if [ ! -f "src/index.js" ]; then
    cat > src/index.js << 'EOF'
// Main entry point for your application
console.log('Webpack is working!');

// You can import CSS files here
// import './styles.css';

// Add your application code here
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded and ready!');
});
EOF
    echo "✅ Created src/index.js"
fi

# Add npm scripts to package.json
echo "📝 Adding npm scripts to package.json..."

# Use node to add scripts to package.json
node -e "
const fs = require('fs');
const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));

packageJson.scripts = {
    ...packageJson.scripts,
    'build': 'webpack --mode production',
    'dev': 'webpack serve --mode development --open',
    'start': 'webpack serve --mode development',
    'watch': 'webpack --mode development --watch'
};

fs.writeFileSync('package.json', JSON.stringify(packageJson, null, 2));
"

echo "✅ Added npm scripts to package.json"

# Display summary
echo ""
echo "🎉 Webpack setup complete!"
echo ""
echo "📋 Installed packages:"
echo "   • webpack & webpack-cli"
echo "   • html-webpack-plugin"
echo "   • style-loader & css-loader"
echo "   • html-loader"
echo "   • webpack-dev-server"
echo ""
echo "📁 Project structure created:"
echo "   • src/ (source files)"
echo "   • dist/ (build output)"
echo "   • src/template.html (HTML template)"
echo "   • src/index.js (main entry point)"
echo ""
echo "🚀 Available commands:"
echo "   • npm run dev    - Start development server"
echo "   • npm run build  - Build for production"
echo "   • npm run watch  - Build and watch for changes"
echo ""
echo "💡 Next steps:"
echo "   1. Add your CSS files to src/"
echo "   2. Import them in src/index.js"
echo "   3. Run 'npm run dev' to start developing"
echo ""
echo "Happy coding! 🎯"
