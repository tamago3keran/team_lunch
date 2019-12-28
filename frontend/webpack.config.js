const path = require('path');

module.exports = {
  entry: {
    group_new: './src/javascripts/pages/groups/group_new.js',
    group_edit: './src/javascripts/pages/groups/group_edit.js',
    lunch_index: './src/javascripts/pages/lunches/lunch_index.js',
    lunch_show: './src/javascripts/pages/lunches/lunch_show.js',
    lunch_new: './src/javascripts/pages/lunches/lunch_new.js',
    user_index: './src/javascripts/pages/users/user_index.js',
    user_new: './src/javascripts/pages/users/user_new.js',
  },

  output: {
    filename: '[name].bundle.js',
    path: path.join(__dirname, '../app/assets/javascripts/packs'),
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env'],
            },
          },
        ],
      },
      {
        test: /\.scss$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
    ],
  },
};
