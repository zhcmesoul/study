`generate-md`通过npm 安装（获得npm，只需[安装Node.js](http://nodejs.org/download/)）：

```
sudo npm install -g markdown-styles

```

创建一个减价文件，然后将其转换为html：

```
mkdir input/
echo "# Hello world\n YOLO" > input/index.md
generate-md --layout github --input ./input --output ./output
google-chrome ./output/index.html

```

通过改变`--layout`参数来尝试不同的布局; 屏幕截图在这个页面的底部。

![剪辑](https://github.com/mixu/markdown-styles/raw/master/screenshots/montage.jpg)

## 生成md CLI选项

- `--input <path>`指定输入目录（默认：）`./input/`。

- `--output <path>`指定输出目录（默认：）`./output/`。

- ```
  --layout <path>
  ```

  指定布局。有可能：

  - 内置布局的名称，如`github`或`mixu-page`。
  - 布局文件夹的路径（完整路径或相对于路径`process.cwd`）。
  - 布局文件夹包括：
    - `./page.html`，在布局中使用的模板
    - `./assets`，将资产文件夹复制到输出
    - `./partials`，[partials](https://www.npmjs.com/package/markdown-styles#partials)目录
    - `./helpers`，[帮手](https://www.npmjs.com/package/markdown-styles#helpers)目录

- `--export <name>`：将内置布局导出到目录。使用`--output <path>`指定写内置的布局位置。例如，`--export github --output ./custom-layout`将复制`github`内置布局`./custom-layout`。

- `--highlight-<language> <module>`：指定用于特定语言的自定义荧光笔模块。例如，`--highlight-csv mds-csv`将突出显示`csv`使用该`mds-csv`模块的任何代码块。

- `--no-header-links`：如果该标志被传递，则不会生成标题链接的HTML。悬停链接默认启用。

## 由此产生的输出



generate-md --layout mixu-gray  --input SPD系统操作手册-备货业务.md --output ./output