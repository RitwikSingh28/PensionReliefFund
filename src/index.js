import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import App from "./App";
import Info from "./Info"
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

const router = createBrowserRouter([
  {
    path: "/",
    element: <App/>
  },
  {
    path: "Info",
    element: <Info/>
  }
]);

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <RouterProvider router={router} >
    <App />
    </RouterProvider>
  </React.StrictMode>
);
