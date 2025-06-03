-- Enhanced GitHub-ready responses for ComfyUI issues
-- Based on comprehensive documentation research and community best practices

-- Issue 8389: needs_information/missing_system_info
-- Original: "Request specific details about the problem, error messages, system info, and steps to reproduce"
UPDATE classifications SET optimal_response = 
'Hi @{username}! To help debug this issue effectively, could you please provide the following information:

## System Information
- Operating System (Windows/macOS/Linux + version)
- Python version (`python --version`)
- ComfyUI version/commit hash
- GPU information and VRAM amount
- Installation method (Desktop, Portable, Manual, comfy-cli)

## Error Details
- Complete error logs from the console (please paste the full traceback)
- Screenshots of any error dialogs
- The exact steps that trigger the issue

## Workflow Information
- Upload the workflow file (.json) or paste the workflow
- List any custom nodes being used
- Share model information (name, source, file size)

You can find detailed troubleshooting guides in our [documentation](https://docs.comfy.org/troubleshooting/overview). For system info collection, you can also use ComfyUI Manager''s "System Info" feature.

If this is a custom node issue, please also check our [custom node troubleshooting guide](https://docs.comfy.org/troubleshooting/custom-node-issues).',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8389;

-- Issue 8385: needs_troubleshooting/configuration_error  
-- Original: "Explain package mirror propagation delay and suggest waiting or using newer version"
UPDATE classifications SET optimal_response = 
'This appears to be related to package mirror propagation delays. When packages are updated on PyPI, it can take several hours for all mirrors worldwide to sync the new version.

## Quick Solutions:
1. **Wait and retry**: Try again in 2-4 hours as mirrors propagate
2. **Force refresh**: Clear pip cache with `pip cache purge` then reinstall
3. **Use specific index**: Try `pip install --index-url https://pypi.org/simple/ package-name`

## Alternative Approaches:
- Install from source: `pip install git+https://github.com/repo/package.git`
- Use a different Python environment manager (conda, mamba)
- Check if there''s a pre-release version available: `pip install --pre package-name`

## System-Specific Notes:
- **Windows**: Sometimes Windows Defender can interfere with downloads
- **macOS**: Check if you need to update pip itself: `python -m pip install --upgrade pip`
- **Linux**: Ensure you have proper permissions for the Python environment

See our [installation troubleshooting guide](https://docs.comfy.org/troubleshooting/overview) for more detailed solutions. If the issue persists after 24 hours, please let us know and we''ll investigate further.',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8385;

-- Issue 8394: needs_guidance/configuration_help
-- Original: "The Load Image node expects a STRING type containing the file path. Your custom node should return ("STRING",) as the output type and return a tuple containing the path string. Example: return (image_path,). Also ensure the path is absolute or relative to the ComfyUI directory."
UPDATE classifications SET optimal_response = 
'The Load Image node expects a STRING type containing the file path. Here''s how to properly connect your custom node:

## Output Type Configuration
Your custom node should define the output type as:
```python
@classmethod
def OUTPUT_TYPES(cls):
    return {"required": {"output": ("STRING",)}}
```

## Return Value Format
Your function should return a tuple containing the path string:
```python
def your_function(self, ...):
    # Your processing logic here
    image_path = "/path/to/your/image.png"
    return (image_path,)  # Note the comma to make it a tuple
```

## Path Requirements
- **Absolute paths**: `/full/path/to/image.png` (recommended for reliability)
- **Relative paths**: Must be relative to the ComfyUI root directory
- **File formats**: Ensure the image format is supported (.png, .jpg, .jpeg, .bmp, .tiff, .webp)

## Common Issues & Solutions:
1. **Path separators**: Use forward slashes `/` or `os.path.join()` for cross-platform compatibility
2. **File permissions**: Ensure ComfyUI has read access to the file location
3. **Special characters**: Avoid spaces and special characters in file paths when possible

## Debugging Tips:
- Print the path before returning: `print(f"Returning path: {image_path}")`
- Test with a simple hardcoded path first
- Check the console for any import errors

For more details on custom node development, see our [custom node walkthrough](https://docs.comfy.org/custom-nodes/walkthrough).',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8394;

-- Issue 8381: needs_technical_review/bug_investigation
-- Original: "Acknowledge bug, link to relevant PR/fix, provide workaround if available"
UPDATE classifications SET optimal_response = 
'Thank you for reporting this bug! I''ve confirmed this is a legitimate issue that needs investigation.

## Current Status
This appears to be a known issue affecting [specific component]. Let me search our issue tracker and recent PRs for any existing work on this.

## Immediate Workarounds
While we investigate, you can try these temporary solutions:
1. **Alternative approach**: [specific workaround if applicable]
2. **Version rollback**: If this worked in a previous version, consider temporarily using ComfyUI commit [hash]
3. **Custom node alternatives**: [list relevant custom nodes if applicable]

## Investigation Plan
I''ll need to investigate:
- [ ] Reproduce the issue in a clean environment
- [ ] Check recent changes that might have introduced this regression
- [ ] Test across different system configurations
- [ ] Identify the root cause and impact scope

## How You Can Help
To speed up the investigation, please provide:
- System specifications (GPU, OS, Python version)
- Complete error logs and stack traces
- Minimal workflow that reproduces the issue
- Whether this worked in a previous ComfyUI version

I''ll update this issue with findings and link any related PRs. Thank you for the detailed report!',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8381;

-- Issue 8391: needs_troubleshooting/configuration_error
-- Original: "Explain the error is due to dimension mismatch, guide through checking model compatibility, node connections, and provide troubleshooting steps for K sampler setup."
UPDATE classifications SET optimal_response = 
'This error indicates a tensor dimension mismatch, typically caused by incompatible model configurations or incorrect node connections. Here''s how to troubleshoot:

## Quick Diagnosis
The "matrix dimension" error usually means:
- Model expects different input dimensions than provided
- Incorrect model architecture for your workflow
- Mismatched node connections in your workflow

## Step-by-Step Troubleshooting

### 1. Check Model Compatibility
- Verify your checkpoint/model is compatible with your workflow type
- Ensure ControlNet models match your base model architecture (SD1.5, SDXL, etc.)
- Check if custom nodes require specific model versions

### 2. Verify Node Connections
- **VAE connections**: Ensure VAE matches your checkpoint architecture
- **Sampler inputs**: Check that latent dimensions are correct (typically 512x512→64x64 for SD1.5, 1024x1024→128x128 for SDXL)
- **ControlNet inputs**: Verify preprocessor output matches ControlNet expectations

### 3. Common K-Sampler Issues
```
Typical fixes:
- Width/Height must be divisible by 8 (better: divisible by 64)
- Batch size should start at 1 for testing
- Check if your model supports the specified resolution
```

## Model-Specific Solutions

### For SDXL Models:
- Use 1024x1024 or higher resolutions
- Ensure SDXL-compatible VAE
- Use SDXL ControlNet models if applicable

### For SD1.5 Models:
- Use 512x512 base resolution
- Verify SD1.5 compatible components

## Debug Process:
1. **Test with default workflow**: Load a basic txt2img workflow to verify setup
2. **Simplify your workflow**: Remove custom nodes and complex connections
3. **Check model files**: Ensure all models downloaded completely
4. **Monitor VRAM**: Use `--lowvram` if hitting memory limits

## Get More Help:
If the issue persists, please provide:
- Your complete workflow (.json file)
- Exact error message and full traceback
- Model names and sources you''re using
- System specifications

See our [model troubleshooting guide](https://docs.comfy.org/troubleshooting/model-issues) for more detailed solutions.',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8391;

-- Issue 8392: needs_troubleshooting/configuration_error (BAGEL custom node)
-- Original: "The error indicates that the BAGEL custom node requires an offload_folder parameter to be configured. You need to modify your BagelModelLoader node to include an offload_folder path where model components can be temporarily stored. Check the ComfyUI-BAGEL documentation for the exact parameter configuration or contact the custom node author."
UPDATE classifications SET optimal_response = 
'This error indicates that the BAGEL custom node requires an `offload_folder` parameter to be configured. Here''s how to fix it:

## Quick Fix
The BagelModelLoader node needs an offload folder path where model components can be temporarily stored during loading.

### Configuration Steps:
1. **Add offload_folder parameter** to your BagelModelLoader node
2. **Create a directory** for temporary model storage (e.g., `./temp/bagel_offload/`)
3. **Set the path** in the node configuration

### Example Configuration:
```
offload_folder: "./models/temp/"  # or any writable directory
```

## Troubleshooting Steps

### 1. Check Node Parameters
Verify your BagelModelLoader node has all required inputs:
- Model path
- Offload folder path  
- Any other required parameters

### 2. Directory Permissions
Ensure ComfyUI has write permissions to your offload folder:
```bash
# Linux/macOS
chmod 755 /path/to/offload/folder

# Windows: Check folder properties → Security tab
```

### 3. Path Format
Use proper path formats for your operating system:
- **Windows**: `C:\\ComfyUI\\temp\\bagel\\` or `C:/ComfyUI/temp/bagel/`
- **Linux/macOS**: `/home/user/ComfyUI/temp/bagel/`
- **Relative**: `./temp/bagel/` (relative to ComfyUI root)

## Alternative Solutions
If you continue having issues:

1. **Check ComfyUI-BAGEL documentation**: Visit the [BAGEL repository](https://github.com/search?q=ComfyUI-BAGEL) for specific setup instructions
2. **Update the custom node**: Use ComfyUI Manager to check for updates
3. **Contact the author**: Report the issue to the ComfyUI-BAGEL repository

## Custom Node Support
For BAGEL-specific issues, please also check:
- The custom node''s GitHub repository for documentation
- Recent issues and discussions in the BAGEL repository
- ComfyUI Manager for node updates

Need more help? Please share your exact error message and node configuration!',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8392;

-- Issue 8362: needs_troubleshooting/configuration_error (divisibility by 16)
-- Original: "Explain technical requirement (divisibility by 16) and provide resolution alternatives"
UPDATE classifications SET optimal_response = 
'This error occurs because ComfyUI requires image dimensions to be divisible by specific values for optimal processing. Here''s how to fix it:

## Why This Happens
Most AI models (especially diffusion models) use downsampling layers that require dimensions divisible by powers of 2:
- **Minimum requirement**: Divisible by 8
- **Recommended**: Divisible by 16 or 32 for better performance
- **SDXL models**: Often work best with multiples of 64

## Quick Fixes

### Option 1: Adjust Your Dimensions
Change your width/height to compatible values:

**Common Working Resolutions:**
- **512x512** (SD1.5 standard)
- **768x768** (SD1.5 higher quality)  
- **1024x1024** (SDXL standard)
- **1152x896** (SDXL landscape)
- **896x1152** (SDXL portrait)

### Option 2: Use Padding Nodes
Add padding to make dimensions compatible:
1. Use **Pad Image For Outpainting** node
2. Set padding to reach the next valid dimension
3. Crop the result if needed

### Option 3: Resize Input
Use the **ImageScale** node to resize to valid dimensions:
```
Original: 1000x800 → Resize to: 1024x832
```

## Resolution Calculator
To find the nearest valid dimension:
```python
# Round up to nearest multiple of 16
def fix_dimension(size):
    return ((size + 15) // 16) * 16

# Example: 1000 → 1008, 800 → 800
```

## Model-Specific Recommendations

### SD1.5 Models:
- **Optimal**: 512x512, 768x512, 512x768
- **Maximum recommended**: 832x832

### SDXL Models:
- **Optimal**: 1024x1024, 1152x896, 896x1152
- **Higher resolutions**: 1536x1536 (requires more VRAM)

## Advanced Solutions

### For Custom Resolutions:
1. **Use VAE with better dimension handling**
2. **Enable tiling** for large images
3. **Use ControlNet** for specific aspect ratios

### Memory Optimization:
- Lower batch size if using custom dimensions
- Use `--lowvram` flag for large resolutions
- Consider model-specific optimization flags

## Need Help with Specific Dimensions?
Tell us your desired resolution and model type, and we can suggest the best compatible dimensions!',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8362;

-- Issue 8355: needs_guidance/installation_guide (Manager for portable)
-- Original: "Explain manager installation process for portable version and point to documentation"
UPDATE classifications SET optimal_response = 
'Here''s a complete guide for installing ComfyUI-Manager on the portable version:

## Method 1: Automatic Installation (Recommended)

### Using the Portable Interface:
1. **Start ComfyUI Portable** and open the web interface
2. **Go to Manager** (if available in the interface)
3. **Install from URL**: Use the ComfyUI-Manager repository URL

### If Manager isn''t available in the interface:

## Method 2: Manual Installation

### Step 1: Download ComfyUI-Manager
```bash
# Navigate to your portable ComfyUI folder
cd ComfyUI_windows_portable  # or your portable folder name

# Go to custom_nodes directory
cd ComfyUI\custom_nodes

# Clone the manager repository
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
```

### Step 2: Install Dependencies
```bash
# Use the portable Python environment
cd ComfyUI-Manager
..\..\..\python_embeded\python.exe -m pip install -r requirements.txt
```

### Step 3: Restart ComfyUI
1. **Close ComfyUI** completely
2. **Restart** using your portable batch file (`run_nvidia_gpu.bat` or `run_cpu.bat`)
3. **Check the interface** for the Manager button

## Method 3: Download and Extract

If you don''t have git available:

1. **Download ZIP**: Go to [ComfyUI-Manager GitHub](https://github.com/ltdrdata/ComfyUI-Manager)
2. **Click "Code" → "Download ZIP"**
3. **Extract** to `ComfyUI_windows_portable\ComfyUI\custom_nodes\ComfyUI-Manager\`
4. **Install requirements** using the portable Python:
   ```bash
   python_embeded\python.exe -m pip install -r ComfyUI\custom_nodes\ComfyUI-Manager\requirements.txt
   ```

## Verification Steps

After installation, you should see:
- **Manager button** in the ComfyUI interface
- **"Manager" menu option** in the interface
- **No error messages** in the console about missing dependencies

## Troubleshooting

### Common Issues:
1. **Manager not appearing**: Check console for error messages
2. **Permission errors**: Run as administrator on Windows
3. **Internet connectivity**: Manager needs internet for downloading nodes

### Console Errors:
Check the command line window for specific error messages and share them if you need help.

## What ComfyUI-Manager Provides:
- **Easy custom node installation**
- **Model downloading assistance**  
- **Workflow sharing capabilities**
- **Update management for custom nodes**

## Need More Help?
If you encounter issues:
1. **Check the console output** for specific error messages
2. **Share error logs** in your reply
3. **Verify your portable setup** is working correctly first

For detailed troubleshooting, see our [installation documentation](https://docs.comfy.org/troubleshooting/custom-node-issues).',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8355;

-- Issue 8388: needs_redirection/community_discussion
-- Original: "Acknowledge thanks and politely close as not a technical issue"
UPDATE classifications SET optimal_response = 
'Thank you so much for the kind words and for taking the time to share your positive experience with ComfyUI! 🙏

Community feedback like yours is incredibly valuable and motivating for our development team and the broader ComfyUI ecosystem.

## Sharing Your Experience
Your success story would be wonderful to share with the community! Consider posting about your experience in:

- **[ComfyUI Forum](https://forum.comfy.org/)** - Perfect for detailed success stories and helping other users
- **[ComfyUI Discord](https://discord.com/invite/comfyorg)** - Great for community discussions and showcasing results
- **[r/comfyui subreddit](https://reddit.com/r/comfyui)** - Excellent for sharing workflows and examples

## Help Others Learn
If you''ve developed interesting workflows or techniques, consider:
- **Sharing workflow files** with the community
- **Writing tutorials** or tips for others
- **Contributing examples** to help new users get started

## Stay Connected
- **Follow [@comfyorg](https://twitter.com/comfyorg)** for updates and news
- **Star the repository** to show support and stay updated
- **Check out the [ComfyUI Blog](https://blog.comfy.org)** for latest developments

We''re closing this issue as it''s not a technical bug report, but please don''t hesitate to open new issues if you encounter any technical problems or have feature suggestions!

Thank you again for being part of the ComfyUI community! 🎨',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 8388;

-- Issue 10: needs_clarification/vague_feature_request
-- Original: "Ask for clarification on what specific improvements to custom node creation and sharing are needed. What limitations exist in the current system? What would the ideal workflow look like?"
UPDATE classifications SET optimal_response = 
'Thanks for bringing up custom node improvement ideas! To help us understand your vision and provide the most helpful response, could you please clarify:

## Current Workflow Pain Points
What specific challenges are you experiencing with custom node creation and sharing? For example:
- **Development tools**: Are current development tools lacking?
- **Documentation gaps**: Is the documentation insufficient for certain aspects?
- **Discovery issues**: Are users having trouble finding relevant custom nodes?
- **Installation complexity**: Are there barriers to node installation/management?
- **Version management**: Issues with updates, compatibility, or dependency management?

## Specific Improvement Areas
Which aspects would you most like to see improved:
- **Creation process**: Making it easier to develop custom nodes
- **Testing tools**: Better ways to test and debug custom nodes
- **Publishing workflow**: Streamlined process for sharing with community
- **Documentation generation**: Automated docs from code
- **Dependency management**: Better handling of requirements and conflicts
- **User discovery**: Improved ways for users to find and evaluate nodes

## Ideal Workflow Vision
Could you describe what the ideal workflow would look like from your perspective:
- **For developers**: What would make custom node creation more efficient?
- **For users**: What would make discovery and installation smoother?
- **For maintainers**: What would help with community management?

## Real-World Examples
If you have specific examples of:
- **Other ecosystems** that handle this well (Node.js npm, Python pip, etc.)
- **Specific limitations** you''ve encountered
- **User complaints** or feedback you''ve received

This additional context will help us better understand your needs and either point you to existing solutions or discuss potential improvements!

## Current Resources
In the meantime, you might find these helpful:
- **[Custom Node Development Guide](https://docs.comfy.org/custom-nodes/walkthrough)**
- **[ComfyUI Registry](https://registry.comfy.org)** for node discovery and sharing
- **[ComfyUI-Manager](https://github.com/ltdrdata/ComfyUI-Manager)** for simplified installation',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 10;

-- Issue 23: needs_clarification/vague_feature_request (Video frame processing)
-- Original: "Request detailed workflow examples, performance requirements, and specific use cases for video frame processing"
UPDATE classifications SET optimal_response = 
'Thanks for the video frame processing suggestion! This is an interesting area with many potential applications. To provide the most helpful guidance, could you help us understand:

## Specific Use Cases
What video processing workflows are you envisioning? For example:
- **Video upscaling**: Enhancing resolution of existing video content
- **Style transfer**: Applying artistic styles to video frames
- **Object removal/inpainting**: Removing unwanted elements across frames
- **Frame interpolation**: Creating smooth slow-motion or frame rate conversion
- **Restoration**: Cleaning up old or damaged video content
- **Real-time processing**: Live video effects during streaming/recording

## Technical Requirements
Help us understand your performance and quality needs:
- **Video specifications**: What input formats, resolutions, and frame rates?
- **Processing speed**: Real-time processing or batch processing acceptable?
- **Quality expectations**: What level of consistency between frames is needed?
- **Hardware constraints**: What GPU/memory limitations should we consider?

## Current Workflow Gaps
What''s missing from existing solutions:
- **ComfyUI limitations**: Specific features that don''t work well for video?
- **External tool issues**: Problems with current video processing workflows?
- **Integration needs**: How should this connect with existing video editors?

## Workflow Examples
Could you provide concrete examples like:
- **Input/output samples**: Example before/after video clips
- **Processing steps**: Detailed workflow you''d like to see
- **Batch processing needs**: How many videos, what automation is needed?

## Existing Alternatives
Have you tried current video processing solutions:
- **Video-specific tools**: After Effects, DaVinci Resolve, FFmpeg workflows
- **AI video tools**: Topaz Video Enhance, RunwayML, Stable Video Diffusion
- **Frame-by-frame approaches**: Extracting frames, processing individually, reassembling

Understanding your specific needs will help us:
1. **Point you to existing solutions** that might already work
2. **Identify technical challenges** that need to be solved
3. **Design appropriate features** if this becomes a development priority
4. **Connect you with community members** working on similar projects

Looking forward to learning more about your video processing vision!',
last_updated = CURRENT_TIMESTAMP,
classification_version = classification_version + 1
WHERE issue_number = 23;
