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
        
        
        'custom-button-3' : '#7CB69D',
        'custom-button-4' : '#839dbd',
        'hover-button-1': '#C58B60',
        'hover-button-2': '#667E74',

        'hover-button-4': '#5d728c',
        'custom-text': '#492801',
        'custom-text2': '#3d3d4c',
        'custom-calendar': '#754058',
        'custom-calendar-hover': '#675c77',
        'custom-delete1': '#be6f8d',
        'custom-delete-hover1': '#ea4c77',
        'custom-button-purple': '#9476a0',
        'custom-hover-lightblue': '#9291bd',
        'custom-diary': '#9286aa',
        'custom-diary-content': '#faf8fc',
        'custom-diary-content2': '#501204',
        'custom-index': '#bd837a',
        'custom-index-hover': '#e89aa0',
        'custom-diary-title': '#be6f8d',
        'custom-post': '#f5fbec',
        'custom-post-edit': '#69a9a5',
        'custom-text3': '#153134',
        'custom-post-edit-hover': '#7e8264',
        'custom-post-delete': '#ea4c77',
        'custom-post-delete-hover': '#ca2a20',
        'custom-text-darkreddishpurple': '#492230',
        'custom-post-history': '#784a68',
        'custom-notebook-green': '#8cae87',
        'custom-notebook-text': '#2b4719',
        'custom-page-green': '#fbfcf9',
        'custom-notebook-edit': '#a8b64d',
        'custom-notebook-delete': '#c6045e',
        'hover-button3': '#65c5bf',
        'custom-notebook-edit-hover': '#52dad1',
        'custom-notebook-delete-hover': '#fc05f6',
        'custom-notebook-text-hover': '#78c780',

        'custom-top-button-orange' : '#fba96d',
        'custom-top-button-hover-orange' : '#fe7c70',
        'custom-top-text-brown': '#3f1b01',
        'custom-top-text-green': '#2a4101',
        'custom-top-button-yellowgreen' : '#c0d83b',
        'custom-top-button-hover-yellowgreen' : '#45c36e',

        'custom-home-button-green' : '#83ccc0',
        'custom-home-button-hover-blue' : '#3ea1ba',
        'custom-home-text-green' : '#02342c',
        'custom-home-green' : '#c8e0bf',

        'custom-home-button-pink' : '#a65380',
        'custom-home-text-brown' : '#251001',
        'custom-home-button-hover-pink' : '#d164a1',
        'custom-home-pink' : '#f4d2de',

        'custom-question-button-blue' : '#9693cd',
        'custom-question-button-blue-hover' : '#83a2ea',
        'custom-memo-button' : '#e9a29f',
        'custom-memo' : '#f8e4e3',
        'custom-question' : '#eff4ee',
        'custom-memo-button-hover' : '#f8b079',
        'custom-memo-text' : '#48010d',
        'custom-memo-content' : '#dfd1d6',
        'custom-memo-content-box' : '#d09dac',
        'custom-memo-content-box-hover' : '#e3ac88',
        'custom-question-next-button' : '#c990b9',
        'custom-question-next-button-hover' : '#f293d7',
        'custom-question-answer-button' : '#82acbc',

        'custom-wordbook-edit-button' : '#92a7c1',
        'custom-wordbook-edit-button-hover' : '#478689',
        'custom-wordbook-edit-text' : '#0c4958',
        'custom-wordbook-delete-button' : '#a05467',
        'custom-wordbook-delete-button-hover' : '#9a072d',
        'custom-wordbook-delete-text' : '#fcc1b9',
        'custom-wordbook-text' : '#df7676',
        'custom-wordbook-create-button' : '#df8787',
        'custom-wordbook-create-button-hover' : '#e4b970',
        'custom-wordbook-card-button' : '#b65284',
        'custom-wordbook-card-button-hover' : '#bf76d1',
        'custom-wordbook-card-display-button' : '#94d5eb',
        'custom-wordbook-card-display-button-hover' : '#5a97d7',
        'custom-wordbook-card-hide-button' : '#1d8580',
        'custom-wordbook-card-hide-button-hover' : '#98aa4a',
        'custom-word-text' : '#ee037e',

        'custom-image-button' : '#63425f',

        'flash-yellowgreen' : '#85b9cc',
        'flash-purple' : '#ae89cd',
        'flash-darkred' : '#8e264d',

      },
      backgroundImage: {
        'custom-notebook-gradient': 'linear-gradient(to right, #fce1d2, #fcf3ee)', // グラデーションの色を指定
      },
      fontFamily: {
        'caveat': ['Caveat', 'cursive'],
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
