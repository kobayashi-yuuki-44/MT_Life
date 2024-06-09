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
        'custom-color' : '#131F1F',
        'custom-button-1' : '#E49F6C',
        'custom-button-2' : '#749387',
        'custom-button-3' : '#7CB69D',
        'custom-button-4' : '#839dbd',
        'hover-button-1': '#C58B60',
        'hover-button-2': '#667E74',

        'hover-button-4': '#5d728c',
        'custom-text': '#492801',
        'custom-text2': '#3d3d4c',
        'custom-calendar': '#754058',
        'custom-calendar-hover': '#675c77',
        'custom-delete': '#be6f8d',
        'custom-delete-hover': '#ea4c77',
        'custom-edit': '#9476a0',
        'custom-edit-hover': '#9291bd',
        'custom-diary': '#9286aa',
        'custom-diary-content': '#faf8fc',
        'custom-diary-content2': '#501204',
        'custom-index': '#bd837a',
        'custom-index-hover': '#e89aa0',
        'custom-diary-title': '#be6f8d',
      },
      fontFamily: {
        caveat: ['Caveat', 'cursive'],
        'yuji-syuku': ['"Yuji Syuku"', 'serif'],
        'potta-one': ['"Potta One"', 'system-ui'],
        'yuji-boku': ['"Yuji Boku"', 'serif'],
        'kaisei-opti': ['"Kaisei Opti"', 'serif'],
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
