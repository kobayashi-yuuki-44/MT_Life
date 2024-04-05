module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors:{
        'custom-main': '#F4E8E8',
        'custom-header-footer' : '#998391',
        'custom-color' : '#01141A',
        'custom-button-1' : '#E49F6C',
        'custom-button-2' : '#749387',
        'hover-button-1': '#C58B60',
        'hover-button-2': '#667E74',
        'custom-text': '#492801',
      },
      fontFamily: {
        caveat: ['Caveat', 'cursive'],
        'yuji-syuku': ['"Yuji Syuku"', 'serif'],
      },
      fontSize: {
        '2.5xl': '1.6875rem',
        '2.25xl': '1.625rem',
      },
      animation: {
        fadeIn: 'fadeIn 2s ease-in-out'
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
      },
    },
  },
  plugins: [
    require('daisyui'),
    // ... 他のプラグイン ...
  ],
  daisyui: {
    themes: [
      'light', // ここに使用するテーマを指定
      // ... 他のテーマ ...
    ],
    darkMode: false, // ダークモードの自動適用を無効化
  }
}
