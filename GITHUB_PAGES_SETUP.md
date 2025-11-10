# 🚀 GitHub Pages Setup Guide

This guide will help you convert your markdown files into a beautiful, clickable website using GitHub Pages.

## 📋 Prerequisites

- GitHub account
- Repository: `CMP701-Digital-Transformation`
- Basic understanding of Git

---

## 🎯 Option 1: Simple GitHub Pages (Recommended for Start)

### Step 1: Enable GitHub Pages

1. Go to your repository: `https://github.com/goodluckoguzie/CMP701-Digital-Transformation`
2. Click **Settings** (top right)
3. Scroll down to **Pages** (left sidebar)
4. Under **Source**, select:
   - **Branch**: `main` (or `master`)
   - **Folder**: `/ (root)` or `/docs`
5. Click **Save**

### Step 2: Access Your Site

Your site will be available at:
```
https://goodluckoguzie.github.io/CMP701-Digital-Transformation/
```

⏱️ **Note**: It may take 5-10 minutes for the site to be available.

---

## 🎨 Option 2: Jekyll Theme (Better Navigation)

### Step 1: Add Configuration File

The `_config.yml` file has been created in the root directory. This enables:
- Better navigation
- Search functionality
- Professional theme

### Step 2: Enable GitHub Pages with Jekyll

1. Go to **Settings** → **Pages**
2. Select **Source**: `main` branch
3. Select **Theme**: Choose a theme (or use the `_config.yml` we created)
4. Click **Save**

### Step 3: Customize Theme (Optional)

Edit `_config.yml` to customize:
- Site title
- Navigation links
- Author information
- Theme selection

---

## 📝 Option 3: Custom HTML/CSS (Advanced)

### Create an Index Page

Create `index.html` in the root or `/docs` folder:

```html
<!DOCTYPE html>
<html>
<head>
    <title>CMP701 - Digital Transformation</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <nav>
        <ul>
            <li><a href="Week1_UseOfCloudAsAplatformforDigitalTransformation.markdown">Week 1</a></li>
            <li><a href="Week_3_Visualise_the_data.markdown">Week 3</a></li>
            <!-- Add more links -->
        </ul>
    </nav>
    <!-- Your content -->
</body>
</html>
```

---

## 🔗 Making Markdown Files Clickable

### Internal Links (Within Same File)

```markdown
[Link Text](#section-name)
```

### Links to Other Files

```markdown
[Week 1 Content](Week1_UseOfCloudAsAplatformforDigitalTransformation.markdown)
```

### Links to Sections in Other Files

```markdown
[Week 1 - Cloud Section](Week1_UseOfCloudAsAplatformforDigitalTransformation.markdown#cloud-computing)
```

---

## ✅ Checklist

- [ ] Repository is public (or GitHub Pro for private repos)
- [ ] `_config.yml` is in root directory
- [ ] GitHub Pages is enabled in Settings
- [ ] Main README has navigation links
- [ ] All markdown files are properly linked
- [ ] Images are referenced correctly
- [ ] Site is accessible at GitHub Pages URL

---

## 🎨 Improving Navigation

### Add Table of Contents

Add this to the top of each markdown file:

```markdown
## Table of Contents
- [Section 1](#section-1)
- [Section 2](#section-2)
- [Section 3](#section-3)
```

### Use HTML for Better Layout

```html
<div class="navigation-box">
  <h3>Quick Links</h3>
  <ul>
    <li><a href="file1.md">File 1</a></li>
    <li><a href="file2.md">File 2</a></li>
  </ul>
</div>
```

---

## 🐛 Troubleshooting

### Site Not Loading?
- Wait 5-10 minutes after enabling Pages
- Check repository is public
- Verify `_config.yml` syntax is correct
- Check GitHub Pages build logs in **Settings** → **Pages**

### Links Not Working?
- Use relative paths: `[Link](filename.md)`
- Ensure file extensions match (`.md` or `.markdown`)
- Check for typos in filenames

### Theme Not Applying?
- Ensure `_config.yml` is in root directory
- Check Jekyll theme name is correct
- Try clearing browser cache

---

## 📚 Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Jekyll Themes](https://jekyllthemes.io/)
- [Markdown Guide](https://www.markdownguide.org/)

---

## 🎉 Next Steps

1. ✅ Enable GitHub Pages
2. ✅ Test your site
3. ✅ Share the link with others
4. ✅ Continue improving content

**Your site URL**: `https://goodluckoguzie.github.io/CMP701-Digital-Transformation/`

---

Need help? Open an issue or check GitHub Pages documentation!

