# Point Source ID Toggle Feature in Potree.js

## Overview
This document provides instructions on modifying `Potree.js` and its shaders to enable a **Point Source ID Toggle Feature**. The modifications allow filtering points based on predefined source IDs in the point cloud rendering pipeline.

## Steps to Implement

### 1. Modify `renderOctree` Method in `potree.js`
- Move the shader declaration to the top of the method:
  ```js
  let shader = null;
  ```

### 2. Modify `pointcloud.vs` Shader
- Declare the following two uniform variables:
  ```glsl
  uniform int pointSourceIDs[10];
  uniform int pointSourceIDsToggleEnable[1];
  ```
- Insert the filtering logic **below the following condition**:
  ```glsl
  #if defined(clip_point_source_id_enabled)
  ```
  **New Code to Insert:**
  ```glsl
  #if defined(point_source_ids_toggle_enable)
  { // Point source ID filter
    if (int(pointSourceIDsToggleEnable[0]) == 1) {
      for (int i = 0; i < 4; i++) {
        if (int(pointSourceID) == pointSourceIDs[i]) {
          gl_Position = vec4(100.0, 100.0, 100.0, 0.0);
          return;
        }
      }
    }
  }
  #endif
  ```

### 3. Add Shader Define in `renderOctree` Method
- Locate the following line in `renderOctree`:
  ```js
  defines.push("#define clip_point_source_id_enabled");
  ```
- Add the new define **immediately below it**:
  ```js
  defines.push("#define point_source_ids_toggle_enable");
  ```

### 4. Implement `setTogglePointSourceID` Method
- Add the following method **below** `setFilterPointSourceIDRange`:

  ```js
  setTogglePointSourceID(pointSourceIDs) {
      const gl = viewer.renderer.context;

      const location = gl.getUniformLocation(shader.program, "pointSourceIDs");
      const locationUpdate = gl.getUniformLocation(shader.program, "pointSourceIDsToggleEnable");

      if (locationUpdate) {
          if (pointSourceIDs.length === 0) {
              setTimeout(() => {
                  let values = new Int32Array([0]);
                  gl.uniform1iv(locationUpdate, values);
              }, 200);
          } else {
              let values = new Int32Array([1]);
              gl.uniform1iv(locationUpdate, values);
          }
      }

      if (location) {
          const MAX_FILTER_SIZE = 100;
          let values = new Int32Array([
              ...pointSourceIDs.slice(0, MAX_FILTER_SIZE),
              ...new Array(MAX_FILTER_SIZE).fill(-1),
          ].slice(0, MAX_FILTER_SIZE));
          
          gl.uniform1iv(location, values);
      }
  }
  ```

### 5. Usage Example
- To enable point source ID filtering, use:
  ```js
  window.viewer.setTogglePointSourceID([1, 2]);
  ```

## Summary
By following these modifications, you successfully integrate a **Point Source ID Toggle Feature** into `Potree.js`. This feature allows filtering and hiding specific points dynamically during rendering.

---
**Date:** [2025-2-19]  

