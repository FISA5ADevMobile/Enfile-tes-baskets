// import { createSlice } from "@reduxjs/toolkit";
// import type { PayloadAction } from "@reduxjs/toolkit";

// export interface location {
//   lat: number;
//   lng: number;
// }

// export interface UserState {
//   firstName: string;
//   lastName: string;
//   phoneNumber: string;
// }

// const initialState: UserState = {
//   firstName: "",
//   lastName: "",
//   phoneNumber: "",
// };

// export const userSlice = createSlice({
//   name: "user",
//   initialState,
//   reducers: {
//     setFirstName: (state, action: PayloadAction<string>) => {
//       state.firstName = action.payload;
//     },
//     setLastName: (state, action: PayloadAction<string>) => {
//       state.lastName = action.payload;
//     },
//     setPhoneNumber: (state, action: PayloadAction<string>) => {
//       state.phoneNumber = action.payload;
//     },

//     resetUser: () => initialState,
//   },
// });

// // Action creators are generated for each case reducer function
// export const { setFirstName, setLastName, setPhoneNumber } = userSlice.actions;

// // Selectors
// export const selectFirstName = (state: any) => state.user.firstName;
// export const selectLastName = (state: any) => state.user.lastName;
// export const selectPhoneNumber = (state: any) => state.user.phoneNumber;

// export const selectUser = (state: any) => state.user;

// export default userSlice.reducer;
