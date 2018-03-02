# FSOSS
Food Satisfaction Onling Survey System - created by: beyond HORIZON SOLUTIONS 

Capstone Project 2018

## TODO:
- Produce "Create/Edit Survey Word" Use Case for Construction Phase 01

---
### Tips

For force-adding bin/roslyn files, do the following:
```
git add -f "**\*.refresh"
git add -f "**\Bin\roslyn\*"
git commit -m "Website with bin"
```

If you're missing roslyn/cs.exe when you run the website (CTRL + F5), then
- Open **Tools>NuGet Package Manager>Package Manager Console...**
- Type `update-package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r`
- If you are still having problems, also type the following in the Package Manager Console:
	- `update-package -reinstall`
---
