document.addEventListener('DOMContentLoaded', function(){
  // 新規投稿・編集ページのフォームを取得
  const itemForm = document.getElementById('new_item');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!itemForm) return null;
  console.log("preview.jsが読み込まれました");

    // input要素を取得
    const fileField = document.querySelector('input[type="file"][name="item[image]"]');
    // input要素で値の変化が起きた際に呼び出される関数
    fileField.addEventListener('change', function(e){
      console.log("input要素で値の変化が起きました");
      console.log(e.target.files[0]);
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      console.log(blob);

          // 古いプレビューが存在する場合は削除 ２８行目で作成したpreviewがあるかないか
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };

      // 画像を表示するためのdiv要素を生成<div class="preview"></div>
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    // 表示する画像を生成<img class="preview-image" src="blob">
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('style', 'width: 33vh;')
    previewImage.setAttribute('style', 'height: 33vh;')
    previewImage.setAttribute('src', blob);

        // 生成したHTMLの要素をブラウザに表示させる 自分で記述したpreviewsの中に下から３２−３４行分を挿入
        // <親previewList>  const previewList = document.getElementById('previews');
        // <子previewWrapper><div class="preview"></div>
        // <孫previewImage><img class="preview-image" src="blob">
        // <div id="previews">
        // <div class="preview">
        // <img class="preview-image" src="blob">
        // </div>
        // </div>
        previewWrapper.appendChild(previewImage);
        previewList.appendChild(previewWrapper);
    

});
});