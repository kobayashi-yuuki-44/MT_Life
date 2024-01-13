module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        'caveat': ['Caveat', 'cursive'], // 'cursive' はフォールバックフォント
        'm-plus-rounded-1c': ['M PLUS Rounded 1c', 'sans-serif']
      }
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
