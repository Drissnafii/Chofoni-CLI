# 🔥 Chofoni-CLI  

**Tame your API like a wizard** 🧙♂️✨—autocomplete endpoints, pretty-print JSON, and auto-discover routes **without leaving your terminal**.  

## ⚡ Features  
- **Smart Autocomplete**: Type `cfn /pro` → *Tab* → `/api/projects`!  
- **Self-Updating Routes**: Automatically detects endpoints via `/routes` (or falls back to defaults).  
- **Pretty JSON**: No more eyeballing raw API responses.  
- **Zero Config**: Works out of the box with any REST API.  

## 🛠️ Installation  
1. Paste this into your PowerShell `$PROFILE`:  
    ```powershell
    function chofoni {
         # [PASTE THE FULL FUNCTION FROM ABOVE HERE]
    }
    function cfn { chofoni @args }  # Shortcut
    ```
2. Reload:  
    ```powershell
    . $PROFILE
    ```

## 🎮 Usage  
```powershell
cfn                     # Fetches default endpoint (e.g., /api/profile)  
cfn /projects            # Autocomplete magic!  
cfn http://other-api.com # Works with ANY URL!  
```

## 🤯 Pro Tip  
Force-rescan your API routes:  
```powershell
$script:DiscoveredEndpoints = $null  # Clears cache  
```

## ❤️ Why?  
Because **typing full URLs is for peasants**.  

---  

*(Want more? Extend this with auth, rate-limiting, or Swagger parsing! PRs welcome.)*  

```


  ___________________________
 / Chofoni: Because manually \
 \ typing URLs is barbaric.   /
  ---------------------------
            \   ^__^
             \  (oo)\_______
                 (__)\       )\/\
                      ||----w |
                      ||     ||
```  
